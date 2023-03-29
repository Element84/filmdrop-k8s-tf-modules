/*
  Creates the monitoring namespace.

  Commented out due to an issue with a Loki pod getting stuck in the terminating state
  and this namespace never getting deleted.
*/
# resource "kubernetes_namespace" "monitoring" {
#   metadata {
#     labels = {
#       app = "monitoring"
#     }

#     name = "monitoring"
#   }

#   depends_on = [
#     helm_release.linkerd_control_plane
#   ]
# }

# Install all monitoring sub modules
module "grafana-prometheus" {
  source = "./grafana-prometheus"

  depends_on = [
    module.loki
  ]
}

module "loki" {
  source = "./loki"
}

module "promtail" {
  source = "./promtail"
}
