resource "kubernetes_secret" "db_postgres_secret_owner_role" {
  metadata {
    name      = "postgres-secret-owner-role"
    namespace = var.namespace
  }

  binary_data = {
    username = var.owner_username
    password = var.owner_password
  }
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
}
