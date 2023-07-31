module "local_environment" {
  source = "./profiles/core"

  deploy_linkerd                                = var.deploy_linkerd
  high_availability                             = var.high_availability
  cert_validity_period_hours                    = var.cert_validity_period_hours
  linkerd_additional_configuration_values       = var.linkerd_additional_configuration_values
  deploy_grafana_prometheus                     = var.deploy_grafana_prometheus
  deploy_loki                                   = var.deploy_loki
  deploy_promtail                               = var.deploy_promtail
  loki_extra_values                             = var.loki_extra_values
  grafana_prometheus_extra_values               = var.grafana_prometheus_extra_values
  grafana_additional_data_sources               = var.grafana_additional_data_sources
  promtail_extra_values                         = var.promtail_extra_values
  deploy_argo_workflows                         = var.deploy_argo_workflows
  kubernetes_config_file                        = var.kubernetes_config_file
  kubernetes_config_context                     = var.kubernetes_config_context
  deploy_ingress_nginx                          = var.deploy_ingress_nginx
  nginx_extra_values                            = var.nginx_extra_values
  namespace_annotations                         = var.namespace_annotations
  deploy_titiler                                = var.deploy_titiler
  deploy_stacfastapi                            = var.deploy_stacfastapi
  deploy_swoop_api                              = var.deploy_swoop_api
  deploy_swoop_caboose                          = var.deploy_swoop_caboose
  swoop_bundle_version                          = var.swoop_bundle_version
  ingress_nginx_additional_configuration_values = var.ingress_nginx_additional_configuration_values
  custom_ingress_nginx_values_yaml              = var.custom_ingress_nginx_values_yaml
  ingress_nginx_version                         = var.ingress_nginx_version
}
