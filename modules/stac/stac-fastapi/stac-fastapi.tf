resource "helm_release" "stac-fastapi" {
  name              = "stac-fastapi"
  namespace         = var.namespace
  repository        = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart             = "stac-fastapi"
  version           = var.stac_version
  atomic            = true
  create_namespace  = false
  wait              = true

  dynamic "set" {
    for_each = var.custom_stac_fastapi_input_map

    content {
      name = set.key
      value = set.value
    }
  }

  set {
    name  = "pgStac.userNameSecret.name"
    value = var.stac_fastapi_secret
  }

  set {
    name  = "pgStac.passwordSecret.name"
    value = var.stac_fastapi_secret
  }

  values = concat(
    [var.custom_stac_fastapi_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_stac_fastapi_values_yaml)],
    length(var.stac_fastapi_additional_configuration_values) == 0 ? [] : var.stac_fastapi_additional_configuration_values
  )
}
