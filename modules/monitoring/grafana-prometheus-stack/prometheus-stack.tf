resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  version    = "45.7.1"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [templatefile("${path.module}/values.yml.tpl", {
    grafana_additional_data_sources   = var.grafana_additional_data_sources
  })]

  dynamic "set" {
    for_each = var.extra_values

    content {
      name = set.key
      value = set.value
    }
  }
}
