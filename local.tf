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
  deploy_db_migration                           = var.deploy_db_migration
  deploy_minio                                  = var.deploy_minio
  deploy_db_init                                = var.deploy_db_init
  deploy_postgres                               = var.deploy_postgres
  swoop_bundle_version                          = var.swoop_bundle_version
  ingress_nginx_additional_configuration_values = var.ingress_nginx_additional_configuration_values
  custom_ingress_nginx_values_yaml              = var.custom_ingress_nginx_values_yaml
  ingress_nginx_version                         = var.ingress_nginx_version
  custom_postgres_input_map                     = var.custom_postgres_input_map
  custom_minio_input_map                        = var.custom_minio_input_map
  dbadmin_username                              = var.dbadmin_username
  dbadmin_password                              = var.dbadmin_password
  dbadmin_secret                                = var.dbadmin_secret
  owner_username                                = var.owner_username
  owner_password                                = var.owner_password
  owner_secret                                  = var.owner_secret
  api_username                                  = var.api_username
  api_password                                  = var.api_password
  api_secret                                    = var.api_secret
  caboose_username                              = var.caboose_username
  caboose_password                              = var.caboose_password
  caboose_secret                                = var.caboose_secret
  conductor_username                            = var.conductor_username
  conductor_password                            = var.conductor_password
  conductor_secret                              = var.conductor_secret
  minio_access_key                              = var.minio_access_key
  minio_secret_access_key                       = var.minio_secret_access_key
  minio_secret                                  = var.minio_secret
  custom_swoop_input_map                        = var.custom_swoop_input_map
  custom_swoop_api_service_input_map            = var.custom_swoop_api_service_input_map
  custom_swoop_caboose_service_input_map        = var.custom_swoop_caboose_service_input_map
  custom_stac_fastapi_input_map                 = var.custom_stac_fastapi_input_map
  stac_fastapi_username                         = var.stac_fastapi_username
  stac_fastapi_password                         = var.stac_fastapi_password
  stac_fastapi_secret                           = var.stac_fastapi_secret
  stac_fastapi_additional_configuration_values  = var.stac_fastapi_additional_configuration_values
  custom_stac_fastapi_values_yaml               = var.custom_stac_fastapi_values_yaml
}
