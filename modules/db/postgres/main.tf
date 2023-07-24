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

module "dbinit" {

  source = "../../jobs"
  depends_on = [kubernetes_secret.db_postgres_secret_owner_role,
    kubernetes_secret.db_postgres_secret_api_role,
    kubernetes_secret.db_postgres_secret_caboose_role,
  kubernetes_secret.db_postgres_secret_conductor_role]

}

resource "kubernetes_secret" "db_postgres_secret_owner_role" {
  metadata {
    name      = "postgres-secret-owner-role"
    namespace = var.namespace
  }

  binary_data = {
    username = "dXNlcl9vd25lcg=="
    password = "cGFzc19vd25lcg=="
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
    username = "dXNlcl9hcGk="
    password = "cGFzc19hcGk="
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
    username = "dXNlcl9jYWJvb3Nl"
    password = "cGFzc19jYWJvb3Nl"
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
    username = "dXNlcl9jb25kdWN0b3I="
    password = "cGFzc19jb25kdWN0b3I="
  }

  depends_on = [
    helm_release.postgres
  ]

}
