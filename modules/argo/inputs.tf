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

variable create_namespace {
  description = "Whether or not to include to create the namespace"
  type        = bool
  default     = true
}

variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "argo-workflows"
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
