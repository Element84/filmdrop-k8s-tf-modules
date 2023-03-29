module "monitoring" {
  source = "./modules/monitoring"

  depends_on = [
    helm_release.linkerd_control_plane
  ]
}
