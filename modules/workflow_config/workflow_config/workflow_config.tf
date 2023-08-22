resource "helm_release" "workflow_config" {
  name       = "workflow-config"
  namespace  = "swoop"
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts/"
  chart      = "workflow-config"
  atomic     = true

  dynamic "set" {
    for_each = var.custom_config_minio_helm_values

    content {
      name  = set.key
      value = set.value
    }
  }

  set {
    name  = "s3.accessKeyId"
    value = var.aws_access_key
  }

  set {
    name  = "s3.secretAccessKey"
    value = var.aws_secret_access_key
  }

  set {
    name  = "s3.region"
    value = var.aws_region
  }



  values = [
    file("${path.module}/values.yaml")
  ]

}
