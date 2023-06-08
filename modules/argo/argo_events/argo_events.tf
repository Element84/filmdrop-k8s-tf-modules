resource "kubernetes_namespace" "argo_events" {
  metadata {

    labels = {
      app = "argo-events"
    }

    name = "argo-events"
  }
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

resource "null_resource" "argo_events" {
  triggers = {
    key                       = kubernetes_namespace.argo_events.id
    file_hash                 = filemd5("${path.module}/argo-ops/argo-events-stable.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nInstalling Argo Events...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context '${var.kubernetes_config_context}' apply \
      --namespace argo-events -f ${path.module}/argo-ops/argo-events-stable.yaml
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Deleting Argo Events...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context '${self.triggers.kubernetes_config_context}' delete \
      --namespace ${self.triggers.namespace} -f ${path.module}/argo-ops/argo-events-stable.yaml
    EOF
  }

  depends_on = [
    kubernetes_namespace.argo_events
  ]
}

resource "kubernetes_service_account_v1" "argo_ops_workflow_sa" {
  metadata {
    name      = "operate-workflow-sa"
    namespace = "argo-events"
  }

  depends_on = [
    null_resource.argo_events
  ]
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

  depends_on = [
    null_resource.argo_events
  ]
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
    key                       = null_resource.argo_events.id
    file_hash                 = filemd5("${path.module}/argo-ops/default-event-bus.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events default EventBus...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context '${var.kubernetes_config_context}' apply \
      --namespace argo-events -f ${path.module}/argo-ops/default-event-bus.yaml
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context '${self.triggers.kubernetes_config_context}' delete \
      --namespace ${self.triggers.namespace} -f ${path.module}/argo-ops/default-event-bus.yaml
    EOF
  }

  depends_on = [
    null_resource.argo_events,
    kubernetes_cluster_role_binding_v1.argo_ops_workflow_role_binding,
    kubernetes_cluster_role_binding_v1.argo_ops_pods_role_binding
  ]
}

resource "null_resource" "argo_ops_eventsource_webhook" {
  triggers = {
    key                       = null_resource.argo_events.id
    file_hash                 = filemd5("${path.module}/argo-ops/webhook-event-source.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context '${var.kubernetes_config_context}' apply \
      --namespace argo-events -f ${path.module}/argo-ops/webhook-event-source.yaml
    EOF
  }


  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context '${self.triggers.kubernetes_config_context}' delete \
      --namespace ${self.triggers.namespace} -f ${path.module}/argo-ops/webhook-event-source.yaml
    EOF
  }

  depends_on = [
    null_resource.argo_ops_eventbus_default,
  ]
}

resource "null_resource" "argo_ops_sensor" {
  triggers = {
    key                       = null_resource.argo_events.id
    event_bus                 = null_resource.argo_ops_eventbus_default.id
    event_source              = null_resource.argo_ops_eventsource_webhook.id
    pods_role                 = kubernetes_service_account_v1.argo_ops_pods_sa.id
    file_hash                 = filemd5("${path.module}/argo-ops/argo-ops-workflow-sensor.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events Sensor...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context '${var.kubernetes_config_context}' apply \
      --namespace argo-events -f ${path.module}/argo-ops/argo-ops-workflow-sensor.yaml
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events Sensor...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context '${self.triggers.kubernetes_config_context}' delete \
      --namespace ${self.triggers.namespace} -f ${path.module}/argo-ops/argo-ops-workflow-sensor.yaml
    EOF
  }

  depends_on = [
    null_resource.argo_events,
    null_resource.argo_ops_eventbus_default,
    null_resource.argo_ops_eventsource_webhook
  ]
}

resource "null_resource" "argo_ops_eventsource_tracker" {
  triggers = {
    key                       = null_resource.argo_events.id
    file_hash                 = filemd5("${path.module}/argo-ops/tracker-event-source.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events EventSource Tracker...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context '${var.kubernetes_config_context}' apply \
      --namespace argo-events -f ${path.module}/argo-ops/tracker-event-source.yaml
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events EventSource Webhook...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context '${self.triggers.kubernetes_config_context}' delete \
      --namespace ${self.triggers.namespace} -f ${path.module}/argo-ops/tracker-event-source.yaml
    EOF
  }

  depends_on = [
    null_resource.argo_ops_sensor
  ]
}

resource "null_resource" "argo_ops_tracker_sensor" {
  triggers = {
    key                       = null_resource.argo_events.id
    event_bus                 = null_resource.argo_ops_eventbus_default.id
    event_source              = null_resource.argo_ops_eventsource_webhook.id
    pods_role                 = kubernetes_service_account_v1.argo_ops_pods_sa.id
    file_hash                 = filemd5("${path.module}/argo-ops/argo-ops-tracker-sensor.yaml")
    kubernetes_config_file    = var.kubernetes_config_file
    kubernetes_config_context = var.kubernetes_config_context
    namespace                 = "argo-events"
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nCreating Argo Events Tracker Sensor...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
      --context '${var.kubernetes_config_context}' apply \
      --namespace argo-events -f ${path.module}/argo-ops/argo-ops-tracker-sensor.yaml
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      printf "\Destroying Argo Events Tracker Sensor...\n"
      kubectl --kubeconfig ${self.triggers.kubernetes_config_file} \
      --context '${self.triggers.kubernetes_config_context}' delete \
      --namespace ${self.triggers.namespace} -f ${path.module}/argo-ops/argo-ops-tracker-sensor.yaml
    EOF
  }

  depends_on = [
    null_resource.argo_ops_eventsource_tracker
  ]
}
