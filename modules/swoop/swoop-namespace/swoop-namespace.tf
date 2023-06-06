resource "kubernetes_namespace" "swoop" {
  count   = var.create_swoop_namespace == true ? 1 : 0
  metadata {
    annotations = var.namespace_annotations

    labels = {
      app = var.swoop_namespace
    }

    name = var.swoop_namespace
  }
}
