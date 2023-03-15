resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      "linkerd.io/inject" = "enabled"
    }

    labels = {
      app = "monitoring"
    }

    name = "monitoring"
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "helm_release" "grafana" {
  chart            = "grafana"
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  namespace        = "monitoring"
  version          = "6.52.1"
  timeout          = 1800

  values = [
    file("${path.module}/charts/grafana/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}