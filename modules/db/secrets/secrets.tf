resource "random_password" "dbadmin_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "db_postgres_secret_admin_role" {
  metadata {
    name      = var.dbadmin_secret
    namespace = var.namespace
  }

  binary_data = {
    username = var.dbadmin_username == "" ? "cG9zdGdyZXM=" : base64encode(var.dbadmin_username)
    password = var.dbadmin_password == "" ? base64encode(random_password.dbadmin_password.result) : base64encode(var.dbadmin_password)
  }
}

resource "random_password" "owner_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "db_postgres_secret_owner_role" {
  metadata {
    name      = var.owner_secret
    namespace = var.namespace
  }

  binary_data = {
    username = var.owner_username == "" ? "c3dvb3A=" : base64encode(var.owner_username)
    password = var.owner_password == "" ? base64encode(random_password.owner_password.result) : base64encode(var.owner_password)
  }
}

resource "random_password" "api_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "db_postgres_secret_api_role" {
  metadata {
    name      = var.api_secret
    namespace = var.namespace
  }

  binary_data = {
    username = var.api_username == "" ? "c3dvb3BfYXBp" : base64encode(var.api_username)
    password = var.api_password == "" ? base64encode(random_password.api_password.result) : base64encode(var.api_password)
  }
}

resource "random_password" "caboose_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "db_postgres_secret_caboose_role" {
  metadata {
    name      = var.caboose_secret
    namespace = var.namespace
  }

  binary_data = {
    username = var.caboose_username == "" ? "c3dvb3BfY2Fib29zZQ==" : base64encode(var.caboose_username)
    password = var.caboose_password == "" ? base64encode(random_password.caboose_password.result) : base64encode(var.caboose_password)
  }
}

resource "random_password" "conductor_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "db_postgres_secret_conductor_role" {
  metadata {
    name      = var.conductor_secret
    namespace = var.namespace
  }

  binary_data = {
    username = var.conductor_username == "" ? "c3dvb3BfY29uZHVjdG9y" : base64encode(var.conductor_username)
    password = var.conductor_password == "" ? base64encode(random_password.conductor_password.result) : base64encode(var.conductor_password)
  }
}
