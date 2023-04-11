module "stac-fastapi" {
  source = "./modules/stac-fastapi"

  namespace_annotations = {
    "linkerd.io/inject" = "enabled"
  }

  depends_on = [
    helm_release.linkerd_control_plane
  ]
}