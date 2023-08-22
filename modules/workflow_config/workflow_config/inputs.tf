variable "namespace_annotations" {
  type        = map(string)
  description = "Map of annotations applied to the created namespace"
  default     = {}
}

variable "namespace" {
  description = "Name of namespace"
  type        = string
  default     = "swoop"
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = ""
  sensitive   = true
}


variable "custom_config_minio_helm_values" {
  type        = map(any)
  description = "Input values for Workflow-Config Helm Chart"
  default = {
    "minio.host"   = "minio.io"
    "minio.port"   = 9000
    "minio.bucket" = "payloadtest"
  }
}
