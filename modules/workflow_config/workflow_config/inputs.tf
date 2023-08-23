variable namespace_annotations {
  type        = map(string)
  description = "Map of annotations applied to the created namespace"
  default     = {}
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
  description = "secret containing S3 credentials"
  type        = string
  default     = ""
  sensitive   = true
}

variable create_s3_secret {
  description = "boolean specifying if a secret will be created"
  type        = bool
  default     = true
}