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
#
#     name = "monitoring"
#   }
#
#   depends_on = [
#     helm_release.linkerd_control_plane
#   ]
# }

# Install all monitoring sub modules
module "grafana_prometheus" {
  source = "./grafana-prometheus-stack"

  grafana_additional_data_sources = [{
      name        = "Loki"
      type        = "loki"
      isDefault   = "no"
      access      = "proxy"
      url         = "http://loki-read:3100"
      version     = 1
  }]

  depends_on = [
    module.loki
  ]
}

module "loki" {
  source = "./loki-stack"
}

module "promtail" {
  source = "./promtail-stack"
}
