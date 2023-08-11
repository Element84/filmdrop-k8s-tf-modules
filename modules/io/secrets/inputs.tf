variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "io"
}

variable "minio_access_key" {
  description = "Object Storage accessKeyId credential"
  type        = string
  default     = ""
  sensitive   = true
}

variable "minio_secret_access_key" {
  description = "Object Storage secretAccessKey credential"
  type        = string
  default     = ""
  sensitive   = true
}

variable "minio_secret" {
  description = "Object Storage Kubernetes Secret name for credentials"
  type        = string
  default     = "minio-secret-credentials"
  sensitive   = true
}
