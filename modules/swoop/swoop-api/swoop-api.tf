resource "kubernetes_namespace" "swoop" {
  metadata {
    annotations = var.namespace_annotations

    labels = {
      app = "swoop"
    }

    name = "swoop"
  }
}

resource "helm_release" "swoop_api" {
  name = "swoop-api"
  namespace = "swoop"
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart = "swoop-api"
  version = var.swoop_api_version
  atomic = true
  create_namespace = false

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.swoop
  ]
}
