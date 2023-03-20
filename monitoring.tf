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