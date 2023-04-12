resource "kubernetes_namespace" "stac" {
  metadata {
    annotations = var.namespace_annotations

    labels = {
      app = "stac"
    }

    name = "stac"
  }
}

resource "helm_release" "stac-fastapi" {
  name = "stac-fastapi"
  namespace = "stac"
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts/"
  chart = "stac-fastapi"
  atomic = true

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.stac
  ]
}