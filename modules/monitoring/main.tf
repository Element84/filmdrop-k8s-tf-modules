module "monitoring_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_grafana_prometheus == true || var.deploy_loki == true || var.deploy_promtail == true? var.create_namespace : false
  namespace             = var.namespace
}

# Install all monitoring sub modules
module "grafana_prometheus" {
  count   = var.deploy_grafana_prometheus == true ? 1 : 0
  source  = "./grafana-prometheus-stack"
  namespace = var.namespace

  grafana_additional_data_sources = var.grafana_additional_data_sources

  extra_values = var.grafana_prometheus_extra_values

  depends_on = [
    module.monitoring_namespace
  ]

}

module "loki" {
  count   = var.deploy_loki == true ? 1 : 0
  source  = "./loki-stack"
  namespace = var.namespace


  extra_values = var.loki_extra_values

  depends_on = [
    module.monitoring_namespace
  ]

}

module "promtail" {
  count   = var.deploy_promtail == true ? 1 : 0
  source  = "./promtail-stack"
  namespace = var.namespace


  extra_values = var.promtail_extra_values

  depends_on = [
    module.monitoring_namespace
  ]

}
