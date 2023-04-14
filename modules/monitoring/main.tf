# Install all monitoring sub modules
module "grafana_prometheus" {
  count   = var.deploy_grafana_prometheus == true ? 1 : 0
  source  = "./grafana-prometheus-stack"

  grafana_additional_data_sources = var.grafana_additional_data_sources

  extra_values = var.grafana_prometheus_extra_values
}

module "loki" {
  count   = var.deploy_loki == true ? 1 : 0
  source  = "./loki-stack"

  extra_values = var.loki_extra_values
}

module "promtail" {
  count   = var.deploy_promtail == true ? 1 : 0
  source  = "./promtail-stack"

  extra_values = var.promtail_extra_values
}
