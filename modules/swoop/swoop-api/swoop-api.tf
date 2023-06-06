resource "helm_release" "swoop_api" {
  name = "swoop-api"
  namespace = var.swoop_namespace
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart = "swoop-api"
  version = var.swoop_api_version
  atomic = true
  create_namespace = false

  values = concat(
    [var.custom_swoop_api_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_swoop_api_values_yaml)],
    length(var.swoop_api_additional_configuration_values) == 0 ? [] : var.swoop_api_additional_configuration_values
  )
}
