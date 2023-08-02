module "swoop_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_swoop_api == true || var.deploy_swoop_caboose == true || var.deploy_argo_workflows == true || var.deploy_db_migration == true ? var.create_namespace : false
  namespace             = var.namespace
}

module "swoop_bundle" {
  count   = var.deploy_swoop_api == true || var.deploy_swoop_caboose == true || var.deploy_argo_workflows == true || var.deploy_db_migration == true ? 1 : 0
  source  = "./swoop-bundle"

  namespace                                 = var.namespace
  swoop_bundle_version                      = var.swoop_bundle_version
  custom_swoop_api_values_yaml              = var.custom_swoop_api_values_yaml
  swoop_api_additional_configuration_values = var.swoop_api_additional_configuration_values
  custom_input_map                          = var.custom_input_map
  custom_minio_settings                     = var.custom_minio_settings
  custom_postgres_settings                  = var.custom_postgres_settings
  minio_namespace                           = var.minio_namespace
  postgres_namespace                        = var.postgres_namespace
  deploy_swoop_api                          = var.deploy_swoop_api
  deploy_swoop_caboose                      = var.deploy_swoop_caboose
  deploy_db_migration                       = var.deploy_db_migration
  deploy_argo_workflows                     = var.deploy_argo_workflows

  depends_on = [ module.swoop_namespace ]
}
