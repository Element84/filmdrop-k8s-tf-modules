module "service_mesh" {
  source = "../../modules/service_mesh"

  deploy_linkerd                            = var.deploy_linkerd
  high_availability                         = var.high_availability
  cert_validity_period_hours                = var.cert_validity_period_hours
  linkerd_additional_configuration_values   = var.linkerd_additional_configuration_values
}

module "monitoring" {
  source = "../../modules/monitoring"

  deploy_grafana_prometheus       = var.deploy_grafana_prometheus
  deploy_loki                     = var.deploy_loki
  deploy_promtail                 = var.deploy_promtail
  loki_extra_values               = var.loki_extra_values
  grafana_prometheus_extra_values = var.grafana_prometheus_extra_values
  grafana_additional_data_sources = var.grafana_additional_data_sources
  promtail_extra_values           = var.promtail_extra_values

  depends_on = [
    module.service_mesh
  ]
}

module "workflows" {
  source = "../../modules/workflows"

  deploy_argo_workflows       = var.deploy_argo_workflows
  deploy_argo_events          = var.deploy_argo_events
  kubernetes_config_file      = var.kubernetes_config_file
  kubernetes_config_context   = var.kubernetes_config_context
  namespace_annotations       = var.namespace_annotations

  depends_on = [
    module.service_mesh
  ]
}

module "ingress_proxy" {
  source = "../../modules/ingress"

  deploy_ingress_nginx      = var.deploy_ingress_nginx
  kubernetes_config_file    = var.kubernetes_config_file
  kubernetes_config_context = var.kubernetes_config_context
  nginx_http_port           = var.nginx_http_port
  nginx_https_port          = var.nginx_https_port
  nginx_extra_values        = var.nginx_extra_values

  depends_on = [
    module.service_mesh
  ]
}

module "hello_world" {
  source = "../../modules/apps"

  deploy_hello_world    = var.deploy_hello_world
  namespace_annotations = var.namespace_annotations

  depends_on = [
    module.service_mesh,
    module.ingress_proxy
  ]
}
