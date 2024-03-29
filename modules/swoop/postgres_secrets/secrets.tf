data "kubernetes_secret" "db_postgres_secret_owner_role" {
  metadata {
    name      = var.owner_secret
    namespace = var.postgres_namespace
  }
}

resource "kubernetes_secret" "swoop_postgres_secret_owner_role" {
  metadata {
    name      = "${var.namespace}-${var.owner_secret}"
    namespace = var.namespace
  }

  binary_data = {
    username = base64encode(data.kubernetes_secret.db_postgres_secret_owner_role.data["username"])
    password = base64encode(data.kubernetes_secret.db_postgres_secret_owner_role.data["password"])
  }
}

data "kubernetes_secret" "db_postgres_secret_api_role" {
  metadata {
    name      = var.api_secret
    namespace = var.postgres_namespace
  }
}

resource "kubernetes_secret" "swoop_postgres_secret_api_role" {
  metadata {
    name      = "${var.namespace}-${var.api_secret}"
    namespace = var.namespace
  }

  binary_data = {
    username = base64encode(data.kubernetes_secret.db_postgres_secret_api_role.data["username"])
    password = base64encode(data.kubernetes_secret.db_postgres_secret_api_role.data["password"])
  }
}

data "kubernetes_secret" "db_postgres_secret_caboose_role" {
  metadata {
    name      = var.caboose_secret
    namespace = var.postgres_namespace
  }
}

resource "kubernetes_secret" "swoop_postgres_secret_caboose_role" {
  metadata {
    name      = "${var.namespace}-${var.caboose_secret}"
    namespace = var.namespace
  }

  binary_data = {
    username = base64encode(data.kubernetes_secret.db_postgres_secret_caboose_role.data["username"])
    password = base64encode(data.kubernetes_secret.db_postgres_secret_caboose_role.data["password"])
  }
}

data "kubernetes_secret" "db_postgres_secret_conductor_role" {
  metadata {
    name      = var.conductor_secret
    namespace = var.postgres_namespace
  }
}

resource "kubernetes_secret" "swoop_postgres_secret_conductor_role" {
  metadata {
    name      = "${var.namespace}-${var.conductor_secret}"
    namespace = var.namespace
  }

  binary_data = {
    username = base64encode(data.kubernetes_secret.db_postgres_secret_conductor_role.data["username"])
    password = base64encode(data.kubernetes_secret.db_postgres_secret_conductor_role.data["password"])
  }
}
