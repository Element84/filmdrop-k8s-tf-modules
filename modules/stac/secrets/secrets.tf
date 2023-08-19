resource "random_password" "stac_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "stac_secret_admin_role" {
  metadata {
    name      = var.stac_fastapi_secret
    namespace = var.namespace
  }

  binary_data = {
    username = var.stac_fastapi_username == "" ? "dXNlcm5hbWU=" : base64encode(var.stac_fastapi_username)
    password = var.stac_fastapi_password == "" ? base64encode(random_password.stac_password.result) : base64encode(var.stac_fastapi_password)
  }
}
