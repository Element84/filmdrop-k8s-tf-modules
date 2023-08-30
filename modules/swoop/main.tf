module "swoop_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_swoop_api == true || var.deploy_swoop_caboose == true || var.deploy_swoop_conductor == true || var.deploy_argo_workflows == true || var.deploy_db_migration == true ? var.create_namespace : false
  namespace             = var.namespace
}

module "postgres_secrets" {
  source  = "./postgres_secrets"
  count   = var.deploy_swoop_api == true || var.deploy_swoop_caboose == true || var.deploy_swoop_conductor == true || var.deploy_argo_workflows == true || var.deploy_db_migration == true ? (var.deploy_postgres == true || var.deploy_db_init == true ? 1 : 0) : 0

  namespace               = var.namespace
  postgres_namespace      = var.postgres_namespace
  owner_secret            = var.owner_secret
  api_secret              = var.api_secret
  caboose_secret          = var.caboose_secret
  conductor_secret        = var.conductor_secret

  depends_on = [
    module.swoop_namespace,
  ]
}

module "minio_secrets" {
  source  = "./minio_secrets"
  count   = var.deploy_swoop_api == true || var.deploy_swoop_caboose == true || var.deploy_swoop_conductor == true || var.deploy_argo_workflows == true || var.deploy_db_migration == true ? (var.deploy_minio == true ? 1 : 0) : 0

  namespace               = var.namespace
  minio_namespace         = var.minio_namespace
  minio_secret            = var.minio_secret

  depends_on = [
    module.swoop_namespace,
  ]
}

module "swoop_bundle" {
  count   = var.deploy_swoop_api == true || var.deploy_swoop_caboose == true || var.deploy_swoop_conductor == true || var.deploy_argo_workflows == true || var.deploy_db_migration == true ? 1 : 0
  source  = "./swoop-bundle"

  namespace                                 = var.namespace
  swoop_bundle_version                      = var.swoop_bundle_version
  custom_swoop_api_values_yaml              = var.custom_swoop_api_values_yaml
  swoop_api_additional_configuration_values = var.swoop_api_additional_configuration_values
  custom_swoop_input_map                    = var.custom_swoop_input_map
  custom_minio_input_map                    = var.custom_minio_input_map
  custom_postgres_input_map                 = var.custom_postgres_input_map
  minio_namespace                           = var.minio_namespace
  postgres_namespace                        = var.postgres_namespace
  deploy_swoop_api                          = var.deploy_swoop_api
  deploy_swoop_caboose                      = var.deploy_swoop_caboose
  deploy_swoop_conductor                    = var.deploy_swoop_conductor
  deploy_db_migration                       = var.deploy_db_migration
  deploy_argo_workflows                     = var.deploy_argo_workflows
  owner_secret                              = var.owner_secret
  api_secret                                = var.api_secret
  caboose_secret                            = var.caboose_secret
  conductor_secret                          = var.conductor_secret
  minio_secret                              = var.minio_secret
  custom_swoop_api_service_input_map        = var.custom_swoop_api_service_input_map
  custom_swoop_caboose_service_input_map    = var.custom_swoop_caboose_service_input_map
  custom_swoop_conductor_service_input_map  = var.custom_swoop_conductor_service_input_map

  depends_on = [
    module.swoop_namespace,
    module.postgres_secrets,
    module.minio_secrets,
  ]
}
