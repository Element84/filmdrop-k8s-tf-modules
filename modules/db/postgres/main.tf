resource "helm_release" "postgres" {
  name             = "postgres"
  namespace        = var.namespace
  repository       = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart            = "postgres"
  version          = var.postgres_version
  atomic           = true
  create_namespace = false
  wait             = true

  dynamic "set" {
    for_each = var.custom_postgres_input_map

    content {
      name  = set.key
      value = set.value
    }
  }

  set {
    name  = "service.dbHost"
    value = "${var.custom_postgres_input_map["service.name"]}.${var.namespace}"
  }

  set {
    name  = "service.userNameSecret.name"
    value = var.dbadmin_secret
  }

  set {
    name  = "service.passwordSecret.name"
    value = var.dbadmin_secret
  }

  set {
    name  = "migration.enabled"
    value = var.deploy_db_migration
  }

  values = concat(
    [var.custom_postgres_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_postgres_values_yaml)],
    length(var.postgres_additional_configuration_values) == 0 ? [] : var.postgres_additional_configuration_values
  )
}
