resource "helm_release" "swoop_bundle" {
  name              = "swoop-bundle"
  namespace         = var.namespace
  repository        = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart             = "swoop-bundle"
  version           = var.swoop_bundle_version
  atomic            = true
  create_namespace  = false
  wait              = true

  dynamic "set" {
    for_each = var.custom_postgres_input_map

    content {
      name  = "global.postgres.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "global.postgres.migration.enabled"
    value = var.deploy_db_migration
  }

  set {
    name  = "global.postgres.service.dbHost"
    value = "${var.custom_postgres_input_map["service.name"]}.${var.postgres_namespace}"
  }

  set {
    name  = "global.postgres.service.ownerRoleUsernameSecret.name"
    value = "${var.namespace}-${var.owner_secret}"
  }

  set {
    name  = "global.postgres.service.ownerRolePasswordSecret.name"
    value = "${var.namespace}-${var.owner_secret}"
  }

  set {
    name  = "global.postgres.service.apiRoleUsernameSecret.name"
    value = "${var.namespace}-${var.api_secret}"
  }

  set {
    name  = "global.postgres.service.apiRolePasswordSecret.name"
    value = "${var.namespace}-${var.api_secret}"
  }

  set {
    name  = "global.postgres.service.cabooseRoleUsernameSecret.name"
    value = "${var.namespace}-${var.caboose_secret}"
  }

  set {
    name  = "global.postgres.service.cabooseRolePasswordSecret.name"
    value = "${var.namespace}-${var.caboose_secret}"
  }

  set {
    name  = "global.postgres.service.conductorRoleUsernameSecret.name"
    value = "${var.namespace}-${var.conductor_secret}"
  }

  set {
    name  = "global.postgres.service.conductorRolePasswordSecret.name"
    value = "${var.namespace}-${var.conductor_secret}"
  }

  dynamic "set" {
    for_each = var.custom_minio_input_map

    content {
      name  = "global.minio.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "global.minio.service.endpoint"
    value = "http://${var.custom_minio_input_map["service.name"]}.${var.minio_namespace}:${var.custom_minio_input_map["service.port"]}" 
  }

  set {
    name  = "global.minio.service.accessKeyIdSecret.name"
    value = "${var.namespace}-${var.minio_secret}" 
  }

  set {
    name  = "global.minio.service.secretAccessKeySecret.name"
    value = "${var.namespace}-${var.minio_secret}" 
  }


  dynamic "set" {
    for_each = var.custom_swoop_input_map

    content {
      name  = "global.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "global.swoop.api.enabled"
    value = var.deploy_swoop_api
  }

  set {
    name  = "global.swoop.caboose.enabled"
    value = var.deploy_swoop_caboose
  }

  set {
    name  = "global.swoop.argo.enabled"
    value = var.deploy_argo_workflows
  }

  set {
    name  = "swoop-db-migration.enabled"
    value = var.deploy_db_migration
  }

  dynamic "set" {
    for_each = var.custom_swoop_api_service_input_map

    content {
      name  = "swoop-api.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "swoop-api.enabled"
    value = var.deploy_swoop_api
  }

  dynamic "set" {
    for_each = var.custom_swoop_caboose_service_input_map

    content {
      name  = "swoop-caboose.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "swoop-caboose.enabled"
    value = var.deploy_swoop_caboose || var.deploy_argo_workflows
  }

  set {
    name  = "swoop-caboose.argoWorkflows.enabled"
    value = var.deploy_argo_workflows
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.workflowNamespaces[0]"
    value = var.namespace
  }

  set {
    name  = "swoop-caboose.argo-workflows.enabled"
    value = var.deploy_argo_workflows
  }

  values = concat(
    [var.custom_swoop_api_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_swoop_api_values_yaml)],
    length(var.swoop_api_additional_configuration_values) == 0 ? [] : var.swoop_api_additional_configuration_values
  )
}
