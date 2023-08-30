module "service_mesh" {
  source = "../../modules/service_mesh"

  deploy_linkerd                          = var.deploy_linkerd
  high_availability                       = var.high_availability
  cert_validity_period_hours              = var.cert_validity_period_hours
  linkerd_additional_configuration_values = var.linkerd_additional_configuration_values
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

  deploy_stacfastapi                           = var.deploy_stacfastapi
  namespace_annotations                        = var.namespace_annotations
  custom_stac_fastapi_input_map                = var.custom_stac_fastapi_input_map
  stac_fastapi_username                        = var.stac_fastapi_username
  stac_fastapi_password                        = var.stac_fastapi_password
  stac_fastapi_secret                          = var.stac_fastapi_secret
  namespace                                    = var.stac_namespace
  stac_version                                 = var.stac_version
  stac_fastapi_additional_configuration_values = var.stac_fastapi_additional_configuration_values
  custom_stac_fastapi_values_yaml              = var.custom_stac_fastapi_values_yaml

  depends_on = [
    module.service_mesh
  ]
}

module "minio" {
  source = "../../modules/io"

  deploy_minio                          = var.deploy_minio
  minio_version                         = var.minio_version
  namespace_annotations                 = var.namespace_annotations
  namespace                             = var.minio_namespace
  minio_additional_configuration_values = var.minio_additional_configuration_values
  custom_minio_values_yaml              = var.custom_minio_values_yaml
  custom_minio_input_map                = var.custom_minio_input_map
  minio_access_key                      = var.minio_access_key
  minio_secret_access_key               = var.minio_secret_access_key
  minio_secret                          = var.minio_secret

  depends_on = [
    module.service_mesh
  ]
}

module "postgres" {
  source = "../../modules/db"

  deploy_postgres                          = var.deploy_postgres
  deploy_db_init                           = var.deploy_db_init
  postgres_version                         = var.postgres_version
  db_init_version                          = var.db_init_version
  namespace_annotations                    = var.namespace_annotations
  namespace                                = var.postgres_namespace
  postgres_additional_configuration_values = var.postgres_additional_configuration_values
  custom_postgres_values_yaml              = var.custom_postgres_values_yaml
  custom_postgres_input_map                = var.custom_postgres_input_map
  dbadmin_username                         = var.dbadmin_username
  dbadmin_password                         = var.dbadmin_password
  dbadmin_secret                           = var.dbadmin_secret
  owner_username                           = var.owner_username
  owner_password                           = var.owner_password
  owner_secret                             = var.owner_secret
  api_username                             = var.api_username
  api_password                             = var.api_password
  api_secret                               = var.api_secret
  caboose_username                         = var.caboose_username
  caboose_password                         = var.caboose_password
  caboose_secret                           = var.caboose_secret
  conductor_username                       = var.conductor_username
  conductor_password                       = var.conductor_password
  conductor_secret                         = var.conductor_secret
  deploy_db_migration                      = var.deploy_db_migration

  depends_on = [
    module.service_mesh
  ]
}

module "swoop" {
  source = "../../modules/swoop"

  deploy_swoop_api                          = var.deploy_swoop_api
  deploy_swoop_caboose                      = var.deploy_swoop_caboose
  deploy_swoop_conductor                    = var.deploy_swoop_conductor
  deploy_db_migration                       = var.deploy_db_migration
  deploy_argo_workflows                     = var.deploy_argo_workflows
  deploy_minio                              = var.deploy_minio
  deploy_postgres                           = var.deploy_postgres
  deploy_db_init                            = var.deploy_db_init
  swoop_bundle_version                      = var.swoop_bundle_version
  namespace_annotations                     = var.namespace_annotations
  namespace                                 = var.swoop_namespace
  swoop_api_additional_configuration_values = var.swoop_api_additional_configuration_values
  custom_swoop_api_values_yaml              = var.custom_swoop_api_values_yaml
  custom_swoop_input_map                    = var.custom_swoop_input_map
  minio_namespace                           = module.minio.namespace
  custom_minio_input_map                    = var.custom_minio_input_map
  postgres_namespace                        = module.postgres.namespace
  custom_postgres_input_map                 = var.custom_postgres_input_map
  owner_secret                              = var.owner_secret
  api_secret                                = var.api_secret
  caboose_secret                            = var.caboose_secret
  conductor_secret                          = var.conductor_secret
  minio_secret                              = var.minio_secret
  custom_swoop_api_service_input_map        = var.custom_swoop_api_service_input_map
  custom_swoop_caboose_service_input_map    = var.custom_swoop_caboose_service_input_map
  custom_swoop_conductor_service_input_map  = var.custom_swoop_conductor_service_input_map

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

module "workflow_config" {
  source = "../../modules/workflow_config"

  deploy_workflow_config                                = var.deploy_workflow_config
  namespace_annotations                                 = var.namespace_annotations
  aws_access_key                                        = var.aws_access_key
  aws_secret_access_key                                 = var.aws_secret_access_key
  aws_region                                            = var.aws_region
  aws_session_token                                     = var.aws_session_token
  s3_secret                                             = var.s3_secret
  s3_secret_namespace                                   = var.s3_secret_namespace
  create_s3_secret                                      = var.create_s3_secret
  custom_swoop_workflow_config_map                      = var.custom_swoop_workflow_config_map
  swoop_workflow_config_additional_configuration_values = var.swoop_workflow_config_additional_configuration_values
  custom_swoop_workflow_config_values_yaml              = var.custom_swoop_workflow_config_values_yaml
  custom_minio_input_map                                = var.custom_minio_input_map
  minio_secret                                          = var.minio_secret
  minio_namespace                                       = module.minio.namespace
  workflow_config_version                               = var.workflow_config_version

  depends_on = [
    module.service_mesh,
    module.swoop,
    module.minio,
    module.postgres,
  ]

}
