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

module "tiling" {
  source = "../../modules/tiling"

  deploy_titiler        = var.deploy_titiler
  namespace_annotations = var.namespace_annotations

  depends_on = [
    module.service_mesh
  ]
}

module "stac" {
  source = "../../modules/stac"

  deploy_stacfastapi    = var.deploy_stacfastapi
  namespace_annotations = var.namespace_annotations

  depends_on = [
    module.service_mesh
  ]
}

module "minio" {
  source = "../../modules/io"

  deploy_minio                              = var.deploy_minio
  minio_version                             = var.minio_version
  namespace_annotations                     = var.namespace_annotations
  namespace                                 = var.minio_namespace
  minio_additional_configuration_values     = var.minio_additional_configuration_values
  custom_minio_values_yaml                  = var.custom_minio_values_yaml
  custom_input_map                          = var.custom_minio_input_map

  depends_on = [
    module.service_mesh
  ]
}

module "postgres" {
  source = "../../modules/db"

  deploy_postgres                           = var.deploy_postgres
  postgres_version                          = var.postgres_version
  namespace_annotations                     = var.namespace_annotations
  namespace                                 = var.postgres_namespace
  postgres_additional_configuration_values  = var.postgres_additional_configuration_values
  custom_postgres_values_yaml               = var.custom_postgres_values_yaml
  custom_input_map                          = var.custom_postgres_input_map

  depends_on = [
    module.service_mesh
  ]
}

module "swoop" {
  source = "../../modules/swoop"

  deploy_swoop_api                            = var.deploy_swoop_api
  deploy_swoop_caboose                        = var.deploy_swoop_caboose
  deploy_db_migration                         = var.deploy_db_migration
  deploy_argo_workflows                       = var.deploy_argo_workflows
  swoop_bundle_version                        = var.swoop_bundle_version
  namespace_annotations                       = var.namespace_annotations
  namespace                                   = var.swoop_namespace
  swoop_api_additional_configuration_values   = var.swoop_api_additional_configuration_values
  custom_swoop_api_values_yaml                = var.custom_swoop_api_values_yaml
  custom_input_map                            = var.custom_swoop_input_map
  minio_namespace                             = module.minio.namespace
  custom_minio_settings                       = module.minio.minio_values
  postgres_namespace                          = module.postgres.namespace
  custom_postgres_settings                    = module.postgres.postgres_values

  depends_on = [
    module.service_mesh,
    module.minio,
    module.postgres,
  ]
}

module "ingress_proxy" {
  source = "../../modules/ingress"

  namespace                                     = var.ingress_nginx_namespace
  deploy_ingress_nginx                          = var.deploy_ingress_nginx
  kubernetes_config_file                        = var.kubernetes_config_file
  kubernetes_config_context                     = var.kubernetes_config_context
  nginx_extra_values                            = var.nginx_extra_values
  ingress_nginx_version                         = var.ingress_nginx_version
  custom_ingress_nginx_values_yaml              = var.custom_ingress_nginx_values_yaml
  ingress_nginx_additional_configuration_values = var.ingress_nginx_additional_configuration_values

  depends_on = [
    module.service_mesh,
    module.swoop,
    module.minio,
    module.postgres,
  ]
}
