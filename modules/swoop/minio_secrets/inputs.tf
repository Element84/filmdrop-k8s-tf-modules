variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "swoop"
}

variable minio_namespace {
  type        = string
  description = "Namespace for MinIO"
  default     = "io"
}

variable "minio_secret" {
  description = "Object Storage Kubernetes Secret name for credentials"
  type        = string
  sensitive   = true
}
