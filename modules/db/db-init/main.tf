resource "helm_release" "db_init" {
  name             = "swoop-db-init"
  namespace        = var.namespace
  repository       = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart            = "swoop-db-init"
  version          = var.db_init_version
  atomic           = true
  create_namespace = false

  dynamic "set" {
    for_each = var.custom_input_map

    content {
      name  = set.key
      value = set.value
    }
  }

  set {
    name  = "jobName"
    value = var.initialization_jobname
  }

  set {
    name  = "version"
    value = var.initialization_version
  }

  set {
    name  = "namespace"
    value = var.namespace
  }

  set {
    name  = "serviceAccount"
    value = var.initialization_serviceaccount
  }

  set {
    name  = "imagePullPolicy"
    value = var.initialization_imagepullpolicy
  }

  set {
    name  = "postgres.service.ownerRoleUsernameSecret.name"
    value = "postgres-secret-owner-role"
  }

  set {
    name  = "postgres.service.ownerRoleUsernameSecret.key"
    value = "username"
  }

  set {
    name  = "postgres.service.ownerRolePasswordSecret.name"
    value = "postgres-secret-owner-role"
  }

  set {
    name  = "postgres.service.ownerRolePasswordSecret.key"
    value = "password"
  }

  set {
    name  = "postgres.service.apiRoleUsernameSecret.name"
    value = "postgres-secret-api-role"
  }

  set {
    name  = "postgres.service.apiRoleUsernameSecret.key"
    value = "username"
  }

  set {
    name  = "postgres.service.apiRolePasswordSecret.name"
    value = "postgres-secret-api-role"
  }

  set {
    name  = "postgres.service.apiRolePasswordSecret.key"
    value = "password"
  }

  set {
    name  = "postgres.service.cabooseRoleUsernameSecret.name"
    value = "postgres-secret-caboose-role"
  }

  set {
    name  = "postgres.service.cabooseRoleUsernameSecret.key"
    value = "username"
  }

  set {
    name  = "postgres.service.cabooseRolePasswordSecret.name"
    value = "postgres-secret-caboose-role"
  }

  set {
    name  = "postgres.service.cabooseRolePasswordSecret.key"
    value = "password"
  }

  set {
    name  = "postgres.service.conductorRoleUsernameSecret.name"
    value = "postgres-secret-conductor-role"
  }

  set {
    name  = "postgres.service.conductorRoleUsernameSecret.key"
    value = "username"
  }

  set {
    name  = "postgres.service.conductorRolePasswordSecret.name"
    value = "postgres-secret-conductor-role"
  }

  set {
    name  = "postgres.service.conductorRolePasswordSecret.key"
    value = "password"
  }

  values = concat(
    [var.custom_postgres_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_postgres_values_yaml)],
    length(var.postgres_additional_configuration_values) == 0 ? [] : var.postgres_additional_configuration_values
  )

  depends_on = [
    kubernetes_secret.db_postgres_secret_owner_role,
    kubernetes_secret.db_postgres_secret_api_role,
    kubernetes_secret.db_postgres_secret_caboose_role,
    kubernetes_secret.db_postgres_secret_conductor_role
  ]
}
