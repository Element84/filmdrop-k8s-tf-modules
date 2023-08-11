resource "helm_release" "db_init" {
  name             = "swoop-db-init"
  namespace        = var.namespace
  repository       = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart            = "swoop-db-init"
  version          = var.db_init_version
  atomic           = true
  create_namespace = false
  wait             = true

  dynamic "set" {
    for_each = var.custom_postgres_input_map

    content {
      name  = "postgres.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "postgres.service.dbHost"
    value = "${var.custom_postgres_input_map["service.name"]}.${var.namespace}"
  }

  set {
    name  = "postgres.migration.enabled"
    value = var.deploy_db_migration
  }

  set {
    name  = "service.serviceAccount"
    value = "swoop-db-init"
  }


  set {
    name  = "service.serviceAccount"
    value = "swoop-db-init"
  }

  set {
    name  = "service.name"
    value = "db-initialization"
  }

  set {
    name  = "postgres.service.dbAdminUsernameSecret.name"
    value = var.dbadmin_secret 
  }

  set {
    name  = "postgres.service.dbAdminPasswordSecret.name"
    value = var.dbadmin_secret 
  }

  set {
    name  = "postgres.service.ownerRoleUsernameSecret.name"
    value = var.owner_secret
  }

  set {
    name  = "postgres.service.ownerRolePasswordSecret.name"
    value = var.owner_secret
  }

  set {
    name  = "postgres.service.apiRoleUsernameSecret.name"
    value = var.api_secret
  }

  set {
    name  = "postgres.service.apiRolePasswordSecret.name"
    value = var.api_secret
  }

  set {
    name  = "postgres.service.cabooseRoleUsernameSecret.name"
    value = var.caboose_secret
  }

  set {
    name  = "postgres.service.cabooseRolePasswordSecret.name"
    value = var.caboose_secret
  }

  set {
    name  = "postgres.service.conductorRoleUsernameSecret.name"
    value = var.conductor_secret
  }

  set {
    name  = "postgres.service.conductorRolePasswordSecret.name"
    value = var.conductor_secret
  }

  values = concat(
    [var.custom_postgres_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_postgres_values_yaml)],
    length(var.postgres_additional_configuration_values) == 0 ? [] : var.postgres_additional_configuration_values
  )
}
