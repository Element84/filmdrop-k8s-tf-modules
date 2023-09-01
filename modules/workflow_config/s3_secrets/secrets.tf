data "kubernetes_secret" "s3_secret_source" {
  metadata {
    name      = var.s3_secret
    namespace = var.s3_secret_namespace
  }
}

resource "kubernetes_secret" "s3_secret_destination" {
  metadata {
    name      = var.s3_secret
    namespace = var.namespace
  }

  binary_data = {
    access_key_id     = base64encode(data.kubernetes_secret.s3_secret_source.data["access_key_id"])
    secret_access_key = base64encode(data.kubernetes_secret.s3_secret_source.data["secret_access_key"])
    region            = base64encode(data.kubernetes_secret.s3_secret_source.data["region"])
    session_token     = base64encode(data.kubernetes_secret.s3_secret_source.data["session_token"])
    data_bucket       = base64encode(data.kubernetes_secret.s3_secret_source.data["data_bucket"])
  }
}
