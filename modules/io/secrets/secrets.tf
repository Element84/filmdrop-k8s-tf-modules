resource "random_password" "minio_secret_access_key" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "minio_secret_credentials" {
  metadata {
    name      = var.minio_secret
    namespace = var.namespace
  }

  binary_data = {
    access_key_id = var.minio_access_key == "" ? "bWluaW8=" : base64encode(var.minio_access_key)
    secret_access_key = var.minio_secret_access_key == "" ? base64encode(random_password.minio_secret_access_key.result) : base64encode(var.minio_secret_access_key)
  }
}
