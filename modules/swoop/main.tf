module "swoop_namespace" {
  source  = "./swoop-namespace"

  namespace_annotations   = var.namespace_annotations
  create_swoop_namespace  = var.create_swoop_namespace
  swoop_namespace         = var.swoop_namespace
}

module "postgres" {
  count   = var.deploy_postgres == true ? 1 : 0
  source  = "./postgres"

  namespace_annotations                     = var.namespace_annotations
  postgres_version                          = var.postgres_version
  custom_postgres_values_yaml               = var.custom_postgres_values_yaml
  postgres_additional_configuration_values  = var.postgres_additional_configuration_values

  depends_on = [ module.swoop_namespace ]
}

module "minio" {
  count   = var.deploy_minio == true ? 1 : 0
  source  = "./minio"

  namespace_annotations                     = var.namespace_annotations
  minio_version                             = var.minio_version
  custom_minio_values_yaml                  = var.custom_minio_values_yaml
  minio_additional_configuration_values     = var.minio_additional_configuration_values

  depends_on = [ module.swoop_namespace ]
}

module "swoop_api" {
  count   = var.deploy_swoop_api == true ? 1 : 0
  source  = "./swoop-api"

  namespace_annotations                     = var.namespace_annotations
  swoop_api_version                         = var.swoop_api_version
  custom_swoop_api_values_yaml              = var.custom_swoop_api_values_yaml
  swoop_api_additional_configuration_values = var.swoop_api_additional_configuration_values

  depends_on = [ module.swoop_namespace ]
}
