module "monitoring" {
  source = "./modules/monitoring"

  loki_extra_values = {
    "write.podAnnotations.linkerd\\.io/inject" = "enabled"
    "backend.podAnnotations.linkerd\\.io/inject" = "enabled"
    "read.podAnnotations.linkerd\\.io/inject" = "enabled"
  }

  promtail_extra_values = {
    "podAnnotations.linkerd\\.io/inject" = "enabled"
  }

  grafana_prometheus_extra_values = {
    "prometheusOperator.admissionWebhooks.patch.podAnnotations.linkerd\\.io/inject" = "disabled"
    "prometheusOperator.podAnnotations.linkerd\\.io/inject" = "enabled"
    "grafana.podAnnotations.linkerd\\.io/inject" = "enabled"
    "kube-state-metrics.podAnnotations.linkerd\\.io/inject" = "enabled"
  }

  depends_on = [
    helm_release.linkerd_control_plane
  ]
}
