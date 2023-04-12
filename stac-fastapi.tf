module "stac-fastapi" {
  count = var.deploy_stacfastapi == true ? 1 : 0
  source = "./modules/stac-fastapi"

  namespace_annotations = {
    "linkerd.io/inject" = "enabled"
  }

  depends_on = [
    helm_release.linkerd_control_plane
  ]
}