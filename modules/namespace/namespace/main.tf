resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations = var.namespace_annotations

    labels = {
      app = var.namespace
    }

    name = var.namespace
  }
}
