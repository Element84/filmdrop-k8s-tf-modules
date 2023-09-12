module "stac_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_stacfastapi == true ? var.create_namespace : false
  namespace             = var.namespace
}

module "stac_secrets" {
  source  = "./secrets"
  count   = var.deploy_stacfastapi == true ? 1 : 0

  namespace               = var.namespace
  stac_fastapi_username   = var.stac_fastapi_username
  stac_fastapi_password   = var.stac_fastapi_password
  stac_fastapi_secret     = var.stac_fastapi_secret

  depends_on = [
    module.stac_namespace,
  ]
}

module "stac-fastapi" {
  source  = "./stac-fastapi"
  count   = var.deploy_stacfastapi == true ? 1 : 0

  namespace                                     = var.namespace
  stac_version                                  = var.stac_version
  custom_stac_fastapi_input_map                 = var.custom_stac_fastapi_input_map
  stac_fastapi_additional_configuration_values  = var.stac_fastapi_additional_configuration_values
  custom_stac_fastapi_values_yaml               = var.custom_stac_fastapi_values_yaml
  stac_fastapi_secret                           = var.stac_fastapi_secret

  depends_on = [
    module.stac_namespace,
    module.stac_secrets,
  ]
}

module "stac-collection" {
  source  = "./stac-collection"
  count   = var.deploy_staccollection == true ? 1 : 0

  namespace                                     = var.namespace

  depends_on = [
    module.stac_namespace,
    module.stac_secrets,
    module.stac-fastapi
  ]
}
