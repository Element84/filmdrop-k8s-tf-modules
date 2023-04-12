resource "kubernetes_namespace" "tiling" {
  metadata {
    annotations = var.namespace_annotations

    labels = {
      app = "tiling"
    }

    name = "tiling"
  }
}

resource "helm_release" "titiler" {
  name = "titiler"
  namespace = "tiling"
  repository = "https://element84.github.io/titiler-helm-charts"
  chart = "titiler"
  atomic = true

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.tiling
  ]
}
