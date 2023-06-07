variable deploy_argo_workflows {
  type        = bool
  default     = true
  description = "Deploy Argo Workflows"
}

variable deploy_argo_events {
  type        = bool
  default     = true
  description = "Deploy Argo Events"
}

variable kubernetes_config_file {
  description = "Kubernetes config file path."
  type        = string
  default     = "~/.kube/config"
}

variable kubernetes_config_context {
  description = "Kubernetes config context."
  type        = string
  default     = ""
}

variable namespace_annotations {
  type        = map(string)
  description = "MAP of custom defined namespace annotations"
}

variable custom_minio_settings {
  type        = map
  description = "Input values for MinIO"
  default     = {}
}

variable custom_postgres_settings {
  type        = map
  description = "Input values for Postgres"
  default     = {}
}

variable minio_namespace {
  type        = string
  description = "Namespace for MinIO"
  default     = "io"
}

variable postgres_namespace {
  type        = string
  description = "Namespace for Postgres"
  default     = "db"
}

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "argo-workflows"
}
