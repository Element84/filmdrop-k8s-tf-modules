resource "helm_release" "loki" {
  name = "loki"
  namespace = "monitoring"
  create_namespace = true
  repository = "https://grafana.github.io/helm-charts"
  chart = "loki"
  version = "4.8.0"
  atomic = true

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

  # Manually inject linkerd to avoid attaching it to minio jobs
  set {
    name = "backend.podAnnotations.linkerd\\.io/inject"
    value = "enabled"
  }

  set {
    name = "read.podAnnotations.linkerd\\.io/inject"
    value = "enabled"
  }

  set {
    name = "write.podAnnotations.linkerd\\.io/inject"
    value = "enabled"
  }

  # TODO: When integrating services we should probably enable authentication.
  set {
    name = "loki.auth_enabled"
    value = false
  }

  set {
    name = "minio.enabled"
    value = var.minio_enabled
  }

  values = [
    file("${path.module}/values.yaml")
  ]
}
