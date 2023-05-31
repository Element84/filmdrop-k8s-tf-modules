module "swoop_api" {
  count   = var.deploy_swoop_api == true ? 1 : 0
  source  = "./swoop-api"

  namespace_annotations = var.namespace_annotations
  swoop_api_version     = var.swoop_api_version
}
