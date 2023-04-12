module "tiling" {
  count = var.deploy_tiling == true ? 1 : 0

  source = "./modules/tiling"

  namespace_annotations = {
    "linkerd.io/inject" = "enabled"
  }

  depends_on = [
    helm_release.linkerd_control_plane
  ]
}
