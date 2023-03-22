variable "loki_replicas" {
  type = number
  description = "The number of read, write, and backend replicas to deploy. Defaults to 1."
  default = 1

  validation {
    condition = var.loki_replicas >= 1 && var.loki_replicas <= 3
    error_message = "Replicas value must be greater than or equal to 1 and less than or equal to 3."
  }
}

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

  values = [
    file("${path.module}/charts/loki/values.yaml")
  ]

  depends_on = [
    helm_release.linkerd_control_plane
  ]
}
