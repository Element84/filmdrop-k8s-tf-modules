resource "kubernetes_namespace" "monitoring" {
  metadata {
    labels = {
      app = "monitoring"
    }

    name = "monitoring"
  }
}
