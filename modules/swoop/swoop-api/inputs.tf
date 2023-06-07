variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable swoop_api_version {
  type = string
  description = "Version of SWOOP API Helm Chart"
  default = "0.1.0"
}

variable namespace {
  description = "Name of SWOOP Namespace"
  type        = string
  default     = "swoop"
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

variable custom_input_map {
  type        = map
  description = "Input values for SWOOP API Helm Chart"
  default     = {
    "swoopApi.image.repository"                = "quay.io/element84/swoop"
    "swoopApi.image.tag"                       = "latest"
    "swoopApi.container.port"                  = 8000
    "swoopApi.service.type"                    = "ClusterIP"
    "swoopApi.service.port"                    = 8000
    "swoopApi.service.targetPort"              = 8000
    "swoopApi.service.swoopExecutionDir"       = "s3://swoop/execution"
    "swoopApi.service.swoopS3Endpoint"         = "http://minio.io:9000"
    "swoopApi.service.swoopWorkflowConfigFile" = "workflow-config.yml"
    "swoopApi.service.name"                    = "swoop-api"
    "swoopApi.deployment.name"                 = "swoop-api"
    "swoopApi.replicaCount"                    = 1
  }
}
