module "stac-fastapi" {
  count   = var.deploy_stacfastapi == true ? 1 : 0
  source  = "./stac-fastapi"

  namespace_annotations = var.namespace_annotations
}
