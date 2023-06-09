resource "helm_release" "minio" {
  name = "minio"
  namespace = var.namespace
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart = "minio"
  version = var.minio_version
  atomic = true
  create_namespace = false

  dynamic "set" {
    for_each = var.custom_input_map

    content {
      name = set.key
      value = set.value
    }
  }

  values = concat(
    [var.custom_minio_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_minio_values_yaml)],
    length(var.minio_additional_configuration_values) == 0 ? [] : var.minio_additional_configuration_values
  )
}
