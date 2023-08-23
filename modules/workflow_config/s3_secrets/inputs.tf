variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "swoop"
}

variable s3_secret_namespace {
  description = "S3 Object Storage Kubernetes Secret namespace for credentials"
  type        = string
  default     = "swoop"
  sensitive   = true
}

variable s3_secret {
  description = "S3 Object Storage Kubernetes Secret name for credentials"
  type        = string
  default     = "copy-stac-asset-s3-secret"
  sensitive   = true
}
