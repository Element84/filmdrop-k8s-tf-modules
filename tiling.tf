module "tiling" {
  source = "./modules/tiling"

  namespace_annotations = {
    "linkerd.io/inject" = "enabled"
  }

  depends_on = [
    helm_release.linkerd_control_plane
  ]
}
