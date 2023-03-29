resource "helm_release" "promtail" {
  name = "promtail"
  namespace = "monitoring"
  create_namespace = true
  repository = "https://grafana.github.io/helm-charts"
  chart = "promtail"
  version = "6.9.3"
  atomic = true

  # Manually inject linkerd
  set {
    name = "podAnnotations.linkerd\\.io/inject"
    value = "enabled"
  }
}
