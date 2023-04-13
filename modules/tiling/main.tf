module "titiler" {
  count   = var.deploy_titiler == true ? 1 : 0
  source  = "./titiler"

  namespace_annotations = var.namespace_annotations
}
