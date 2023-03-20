resource "helm_release" "promtail" {
  name = "promtail"
  namespace = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart = "promtail"
  version = "6.9.3"
  atomic = true

  # Manually inject linkerd
  set {
    name = "podAnnotations.linkerd\\.io/inject"
    value = "enabled"
  }

  values = [
    file("${path.module}/charts/promtail/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
