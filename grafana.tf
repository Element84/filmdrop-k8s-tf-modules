resource "helm_release" "grafana" {
  chart            = "grafana"
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  namespace        = "monitoring"
  version          = "6.52.1"
  timeout          = 1800

# Manually inject linkerd to avoid attaching it to minio jobs
  set {
    name = "podAnnotations.linkerd\\.io/inject"
    value = "enabled"
  }

  values = [
    file("${path.module}/charts/grafana/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
