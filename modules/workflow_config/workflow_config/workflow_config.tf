resource "helm_release" "workflow_config" {
  name       = "workflow-config"
  namespace  = var.namespace
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts/"
  chart      = "workflow-config"
  atomic     = true

  set {
    name  = "s3.createSecret"
    value = var.create_s3_secret
  }

  set {
    name  = "s3.accessKeyIdSecret.name"
    value = var.s3_secret
  }

  set {
    name  = "s3.secretAccessKeySecret.name"
    value = var.s3_secret
  }

  set {
    name  = "s3.regionSecret.name"
    value = var.s3_secret
  }

  set {
    name  = "s3.sessionTokenSecret.name"
    value = var.s3_secret
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

  set {
    name  = "s3.sessionToken"
    value = var.aws_session_token
  }


  values = [
    file("${path.module}/values.yaml")
  ]

}
