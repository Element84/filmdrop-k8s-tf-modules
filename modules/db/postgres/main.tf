resource "helm_release" "postgres" {
  name             = "postgres"
  namespace        = var.namespace
  repository       = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart            = "postgres"
  version          = var.postgres_version
  atomic           = true
  create_namespace = false

  dynamic "set" {
    for_each = var.custom_input_map

    content {
      name  = set.key
      value = set.value
    }
  }

  values = concat(
    [var.custom_postgres_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_postgres_values_yaml)],
    length(var.postgres_additional_configuration_values) == 0 ? [] : var.postgres_additional_configuration_values
  )
}

resource "kubernetes_secret" "db_postgres_secret_owner_role" {
  metadata {
    name      = "postgres-secret-owner-role"
    namespace = var.namespace
  }

  binary_data = {
    username = var.owner_username
    password = var.owner_password
  }

  depends_on = [
    helm_release.postgres
  ]

}

resource "kubernetes_secret" "db_postgres_secret_api_role" {
  metadata {
    name      = "postgres-secret-api-role"
    namespace = var.namespace
  }

  binary_data = {
    username = var.api_username
    password = var.api_password
  }

  depends_on = [
    helm_release.postgres
  ]

}

resource "kubernetes_secret" "db_postgres_secret_caboose_role" {
  metadata {
    name      = "postgres-secret-caboose-role"
    namespace = var.namespace
  }

  binary_data = {
    username = var.caboose_username
    password = var.caboose_password
  }

  depends_on = [
    helm_release.postgres
  ]

}

resource "kubernetes_secret" "db_postgres_secret_conductor_role" {
  metadata {
    name      = "postgres-secret-conductor-role"
    namespace = var.namespace
  }

  binary_data = {
    username = var.conductor_username
    password = var.conductor_password
  }

  depends_on = [
    helm_release.postgres
  ]

}
