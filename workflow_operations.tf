resource "kubernetes_namespace" "argo_events" {
  metadata {

    labels = {
      app = "argo-events"
    }

    name = "argo-events"
  }

  depends_on = [
    helm_release.argo_artifact_repo,
    helm_release.argo_postgres,
    helm_release.argo_workflows,
    kubernetes_namespace.argo_workflows
  ]
}

resource "kubernetes_secret" "argo_events_postgres_config" {
  metadata {
    name = "argo-postgres-config"
    namespace = "argo-events"
  }

  data = {
    username = "postgres"
    password = "password"
  }

  depends_on = [
    kubernetes_namespace.argo_events
  ]

}

resource "kubernetes_secret" "argo_events_my_minio_cred" {
  metadata {
    name = "my-minio-cred"
    namespace = "argo-events"
  }

  data = {
    accesskey = "admin"
    secretkey = "password"
  }

  depends_on = [
    kubernetes_namespace.argo_events
  ]

}

resource "null_resource" "argo_events_cleanup" {
  triggers = {
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = kubernetes_namespace.argo_events.id
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Everything in Argo Events...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} \
      delete all --all -n ${self.triggers.namespace}

      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} \
      patch crd/sensors.argoproj.io -p '{"metadata":{"finalizers":[]}}' --type=merge

      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} \
      patch crd/eventsources.argoproj.io -p '{"metadata":{"finalizers":[]}}' --type=merge

      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} \
      patch crd/eventbus.argoproj.io -p '{"metadata":{"finalizers":[]}}' --type=merge

      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} \
      delete crd sensors.argoproj.io

      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} \
      delete crd eventsources.argoproj.io

      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} \
      delete crd eventbus.argoproj.io
    EOF
  }

  depends_on = [
    kubernetes_namespace.argo_events
  ]
}

resource "helm_release" "argo_events" {
  name              = "argo-events"
  repository        = "https://argoproj.github.io/argo-helm"
  chart             = "argo-events"
  version           = "2.1.3"
  namespace         = "argo-events"
  create_namespace  = false
  wait              = true
  atomic            = true

  depends_on = [
    null_resource.argo_events_cleanup
  ]
}

resource "kubernetes_service_account_v1" "argo_ops_workflow_sa" {
  metadata {
    name      = "operate-workflow-sa"
    namespace = "argo-events"
  }

  secret {
    name = "${kubernetes_secret_v1.argo_ops_workflow_sa_default_secret.metadata.0.name}"
  }

  depends_on = [
    helm_release.argo_events
  ]
}

resource "kubernetes_secret_v1" "argo_ops_workflow_sa_default_secret" {
  metadata {
    name = "operate-workflow-sa-default-secret"
  }
}


resource "kubernetes_cluster_role_v1" "argo_ops_workflow_role" {
  metadata {
    name      = "operate-workflow-role"
  }

  rule {
    api_groups = ["argoproj.io"]
    resources  = ["workflows"]
    verbs      = ["*"]
  }

  depends_on = [
    kubernetes_service_account_v1.argo_ops_workflow_sa
  ]
}

resource "kubernetes_cluster_role_binding_v1" "argo_ops_workflow_role_binding" {
  metadata {
    name      = "operate-workflow-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "operate-workflow-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "operate-workflow-sa"
    namespace = "argo-events"
  }

  depends_on = [
    kubernetes_service_account_v1.argo_ops_workflow_sa,
    kubernetes_cluster_role_v1.argo_ops_workflow_role
  ]
}


resource "kubernetes_service_account_v1" "argo_ops_pods_sa" {
  metadata {
    name      = "workflow-pods-sa"
    namespace = "argo-events"
  }

  secret {
    name = "${kubernetes_secret_v1.argo_ops_pods_sa_default_secret.metadata.0.name}"
  }

  depends_on = [
    helm_release.argo_events
  ]
}

resource "kubernetes_secret_v1" "argo_ops_pods_sa_default_secret" {
  metadata {
    name = "workflow-pods-sa-default-secret"
  }
}

resource "kubernetes_cluster_role_v1" "argo_ops_pods_role" {
  metadata {
    name      = "workflow-pods-role"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["*"]
  }

  depends_on = [
    kubernetes_service_account_v1.argo_ops_pods_sa
  ]
}

resource "kubernetes_cluster_role_binding_v1" "argo_ops_pods_role_binding" {
  metadata {
    name      = "workflow-pods-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "workflow-pods-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "workflow-pods-sa"
    namespace = "argo-events"
  }

  depends_on = [
    kubernetes_service_account_v1.argo_ops_pods_sa,
    kubernetes_cluster_role_v1.argo_ops_pods_role
  ]
}

resource "kubernetes_cluster_role_binding_v1" "argo_ops_pods_default_role_binding" {
  metadata {
    name      = "workflow-pods-default-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "workflow-pods-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "argo-events"
  }

  depends_on = [
    kubernetes_cluster_role_binding_v1.argo_ops_workflow_role_binding,
    kubernetes_cluster_role_binding_v1.argo_ops_pods_role_binding
  ]
}

resource "null_resource" "argo_ops_eventbus_default" {
  triggers = {
    key                       = helm_release.argo_events.id
    file_hash                 = filemd5("${path.module}/argo-ops/default-event-bus.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events default EventBus...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context ${var.kubernetes_config_context} apply \
      --namespace argo-events -f ${path.module}/argo-ops/default-event-bus.yaml
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} delete \
      --namespace ${self.triggers.namespace} service eventbus-default-stan-svc
    EOF
  }

  depends_on = [
    helm_release.argo_events,
    kubernetes_cluster_role_binding_v1.argo_ops_pods_default_role_binding
  ]
}

resource "null_resource" "argo_ops_eventsource_webhook" {
  triggers = {
    key                       = helm_release.argo_events.id
    file_hash                 = filemd5("${path.module}/argo-ops/webhook-event-source.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context ${var.kubernetes_config_context} apply \
      --namespace argo-events -f ${path.module}/argo-ops/webhook-event-source.yaml
    EOF
  }


  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} delete \
      --namespace ${self.triggers.namespace} service webhook-eventsource-svc
    EOF
  }

  depends_on = [
    null_resource.argo_ops_eventbus_default,
  ]
}

resource "null_resource" "argo_ops_sensor" {
  triggers = {
    key                       = helm_release.argo_events.id
    event_bus                 = null_resource.argo_ops_eventbus_default.id
    event_source              = null_resource.argo_ops_eventsource_webhook.id
    pods_role                 = kubernetes_cluster_role_v1.argo_ops_pods_role.id
    pods_role_binding         = kubernetes_cluster_role_binding_v1.argo_ops_pods_role_binding.id
    file_hash                 = filemd5("${path.module}/argo-ops/argo-ops-workflow-sensor.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events Sensor...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context ${var.kubernetes_config_context} apply \
      --namespace argo-events -f ${path.module}/argo-ops/argo-ops-workflow-sensor.yaml
    EOF
  }

  depends_on = [
    helm_release.argo_events,
    null_resource.argo_ops_eventbus_default,
    null_resource.argo_ops_eventsource_webhook
  ]
}

resource "null_resource" "argo_ops_eventsource_tracker" {
  triggers = {
    key                       = helm_release.argo_events.id
    file_hash                 = filemd5("${path.module}/argo-ops/tracker-event-source.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events EventSource Tracker...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context ${var.kubernetes_config_context} apply \
      --namespace argo-events -f ${path.module}/argo-ops/tracker-event-source.yaml
    EOF
  }


  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context ${self.triggers.kubernetes_config_context} delete \
      --namespace ${self.triggers.namespace} service workflow-events-listener-eventsource-svc
    EOF
  }

  depends_on = [
    null_resource.argo_ops_sensor
  ]
}

resource "null_resource" "argo_ops_tracker_sensor" {
  triggers = {
    key                       = helm_release.argo_events.id
    event_bus                 = null_resource.argo_ops_eventbus_default.id
    event_source              = null_resource.argo_ops_eventsource_webhook.id
    pods_role                 = kubernetes_cluster_role_v1.argo_ops_pods_role.id
    pods_role_binding         = kubernetes_cluster_role_binding_v1.argo_ops_pods_role_binding.id
    file_hash                 = filemd5("${path.module}/argo-ops/argo-ops-tracker-sensor.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events Tracker Sensor...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context ${var.kubernetes_config_context} apply \
      --namespace argo-events -f ${path.module}/argo-ops/argo-ops-tracker-sensor.yaml
    EOF
  }

  depends_on = [
    null_resource.argo_ops_eventsource_tracker
  ]
}
