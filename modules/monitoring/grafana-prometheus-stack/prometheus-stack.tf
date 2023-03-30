resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  version    = "45.7.1"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [
    file("${path.module}/values.yml")
  ]

  # set {
  #   name = "grafana.service.port"
  #   value = var.grafana_service_port
  # }

  # dynamic "set" {
  #   for_each = var.grafana_additional_data_sources

  #   content {
  #     name = "grafana.additionalDataSources[${set.key}].name"
  #     value = set.value.name
  #   }
  # }

  # dynamic "set" {
  #   for_each = var.grafana_additional_data_sources

  #   content {
  #     name = "grafana.additionalDataSources[${set.key}].type"
  #     value = set.value.type
  #   }
  # }

  # dynamic "set" {
  #   for_each = var.grafana_additional_data_sources

  #   content {
  #     name = "grafana.additionalDataSources[${set.key}].isDefault"
  #     value = set.value.isDefault
  #   }
  # }

  # dynamic "set" {
  #   for_each = var.grafana_additional_data_sources

  #   content {
  #     name = "grafana.additionalDataSources[${set.key}].access"
  #     value = set.value.access
  #   }
  # }

  # dynamic "set" {
  #   for_each = var.grafana_additional_data_sources

  #   content {
  #     name = "grafana.additionalDataSources[${set.key}].url"
  #     value = set.value.url
  #   }
  # }

  # dynamic "set" {
  #   for_each = var.grafana_additional_data_sources

  #   content {
  #     name = "grafana.additionalDataSources[${set.key}].version"
  #     value = set.value.version
  #   }
  # }
}
