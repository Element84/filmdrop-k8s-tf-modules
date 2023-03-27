resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  version    = "45.7.1"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [
    file("${path.module}/charts/prometheus-stack/values.yml")
  ]

  depends_on = [
    helm_release.loki
  ]

}