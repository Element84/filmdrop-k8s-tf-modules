variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable deploy_swoop_api {
  description = "Whether or not to include the SWOOP API module resources"
  type        = bool
  default     = true
}

variable create_swoop_namespace {
  description = "Whether or not to include to create the SWOOP Namespace"
  type        = bool
  default     = true
}

variable swoop_namespace {
  description = "Name of SWOOP Namespace"
  type        = string
  default     = "swoop"
}

variable swoop_api_version {
  type = string
  description = "Version of SWOOP API Helm Chart"
  default = "0.1.0"
}

variable deploy_postgres {
  description = "Whether or not to include the Postgres module resources"
  type        = bool
  default     = true
}

variable deploy_minio {
  description = "Whether or not to include the MinIO module resources"
  type        = bool
  default     = true
}

variable postgres_version {
  type = string
  description = "Version of Postgres Helm Chart"
  default = "0.1.0"
}

variable minio_version {
  type = string
  description = "Version of MinIO Helm Chart"
  default = "0.1.0"
}

variable swoop_api_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_swoop_api_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom SWOOP API values.yaml"
}

variable postgres_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_postgres_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom Postgres values.yaml"
}

variable minio_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_minio_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom MinIO values.yaml"
}
