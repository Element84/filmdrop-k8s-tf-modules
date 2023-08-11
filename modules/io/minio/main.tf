resource "helm_release" "minio" {
  name              = "minio"
  namespace         = var.namespace
  repository        = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart             = "minio"
  version           = var.minio_version
  atomic            = true
  create_namespace  = false
  wait              = true

  dynamic "set" {
    for_each = var.custom_minio_input_map

    content {
      name = set.key
      value = set.value
    }
  }

  set {
    name  = "service.endpoint"
    value = "http://${var.custom_minio_input_map["service.name"]}.${var.namespace}:${var.custom_minio_input_map["service.port"]}" 
  }

  set {
    name  = "service.accessKeyIdSecret.name"
    value = var.minio_secret
  }

  set {
    name  = "service.secretAccessKeySecret.name"
    value = var.minio_secret
  }

  values = concat(
    [var.custom_minio_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_minio_values_yaml)],
    length(var.minio_additional_configuration_values) == 0 ? [] : var.minio_additional_configuration_values
  )
}
