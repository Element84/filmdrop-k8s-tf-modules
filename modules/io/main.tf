module "io_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_minio == true ? var.create_namespace : false
  namespace             = var.namespace
}

module "io_secrets" {
  source  = "./secrets"

  namespace               = var.namespace
  minio_access_key        = var.minio_access_key
  minio_secret_access_key = var.minio_secret_access_key
  minio_secret            = var.minio_secret

  depends_on = [
    module.io_namespace,
  ]
}

module "minio" {
  source  = "./minio"
  count   = var.deploy_minio == true ? 1 : 0

  namespace                                 = var.namespace
  minio_version                             = var.minio_version
  minio_additional_configuration_values     = var.minio_additional_configuration_values
  custom_minio_values_yaml                  = var.custom_minio_values_yaml
  custom_minio_input_map                    = var.custom_minio_input_map
  minio_secret                              = var.minio_secret

  depends_on = [
    module.io_namespace,
    module.io_secrets,
  ]
}
