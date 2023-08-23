variable namespace_annotations {
  type        = map(string)
  description = "Map of annotations applied to the created namespace"
  default     = {}
}

variable deploy_workflow_config {
  description = "Whether or not to deploy the workflow configuration module resources"
  type        = bool
  default     = true
}

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "swoop"
}

variable aws_access_key {
  description = "AWS Access Key ID"
  type        = string
  default     = ""
  sensitive   = true
}

variable aws_secret_access_key {
  description = "AWS Secret Access Key"
  type        = string
  default     = ""
  sensitive   = true
}

variable aws_region {
  description = "AWS Region"
  type        = string
  default     = ""
  sensitive   = true
}

variable aws_session_token {
  description = "AWS Session Token"
  type        = string
  default     = ""
  sensitive   = true
}

variable s3_secret {
  description = "S3 Object Storage Kubernetes Secret name for credentials"
  type        = string
  default     = "copy-stac-asset-s3-secret"
  sensitive   = true
}

variable s3_secret_namespace {
  description = "S3 Object Storage Kubernetes Secret namespace for credentials"
  type        = string
  default     = "swoop"
  sensitive   = true
}

variable create_s3_secret {
  description = "boolean specifying if a secret will be created"
  type        = bool
  default     = true
}