data "kubernetes_secret" "minio_secret_credentials" {
  metadata {
    name      = var.minio_secret
    namespace = var.minio_namespace
  }
}

resource "kubernetes_secret" "swoop_minio_secret_credentials" {
  metadata {
    name      = "${var.namespace}-${var.minio_secret}"
    namespace = var.namespace
  }

  binary_data = {
    access_key_id     = base64encode(data.kubernetes_secret.minio_secret_credentials.data["access_key_id"])
    secret_access_key = base64encode(data.kubernetes_secret.minio_secret_credentials.data["secret_access_key"])
  }
}
