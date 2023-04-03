resource "helm_release" "loki" {
  name = "loki"
  namespace = "monitoring"
  create_namespace = true
  repository = "https://grafana.github.io/helm-charts"
  chart = "loki"
  version = "4.8.0"
  atomic = true

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name = "loki.commonConfig.replication_factor"
    value = var.loki_replicas
  }

  set {
    name = "backend.replicas"
    value = var.loki_replicas
  }

  set {
    name = "write.replicas"
    value = var.loki_replicas
  }

  set {
    name = "read.replicas"
    value = var.loki_replicas
  }

  set {
    name = "loki.auth_enabled"
    value = var.loki_auth_enabled
  }

  dynamic "set" {
    for_each = var.extra_values

    content {
      name = set.key
      value = set.value
    }
  }
}
