variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable swoop_bundle_version {
  type = string
  description = "Version of SWOOP Bundle Helm Chart"
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
  description = "Input values for SWOOP Bundle Helm Chart"
  default     = {
    "swoop-api.swoopApi.image.repository"                     = "quay.io/element84/swoop"
    "swoop-api.swoopApi.image.tag"                            = "latest"
    "swoop-api.swoopApi.serviceAccount"                       = "swoop-api"
    "swoop-api.swoopApi.container.port"                       = 8000
    "swoop-api.swoopApi.service.type"                         = "ClusterIP"
    "swoop-api.swoopApi.service.port"                         = 8000
    "swoop-api.swoopApi.service.targetPort"                   = 8000
    "swoop-api.swoopApi.service.swoopExecutionDir"            = "s3://swoop/execution"
    "swoop-api.swoopApi.service.swoopS3Endpoint"              = "http://minio.io:9000"
    "swoop-api.swoopApi.service.swoopWorkflowConfigFile"      = "workflow-config.yml"
    "swoop-api.swoopApi.service.name"                         = "swoop-api"
    "swoop-api.swoopApi.deployment.name"                      = "swoop-api"
    "swoop-api.swoopApi.replicaCount"                         = 1
    "swoop-caboose.swoopCaboose.image.repository"             = "quay.io/element84/swoop-go"
    "swoop-caboose.swoopCaboose.image.tag"                    = "latest"
    "swoop-caboose.swoopCaboose.container.port"               = 8000
    "swoop-caboose.swoopCaboose.service.type"                 = "ClusterIP"
    "swoop-caboose.swoopCaboose.service.port"                 = 8000
    "swoop-caboose.swoopCaboose.service.targetPort"           = 8000
    "swoop-caboose.swoopCaboose.service.swoopS3Endpoint"      = "http://minio.io:9000"
    "swoop-caboose.swoopCaboose.service.swoopConfigFile"      = "/opt/swoop-go/fixtures/swoop-config.yml"
    "swoop-caboose.swoopCaboose.service.name"                 = "swoop-caboose"
    "swoop-caboose.swoopCaboose.deployment.name"              = "swoop-caboose"
    "swoop-caboose.swoopCaboose.replicaCount"                 = 1
    "swoop-caboose.swoopCaboose.argoWorkflows.objectCounts"   = 5
    "swoop-caboose.swoopCaboose.argoWorkflows.crds.install"   = true
    "swoop-caboose.swoopCaboose.argoWorkflows.serviceAccount" = "argo"
    "swoop-caboose.swoopCaboose.serviceAccount"               = "argo"
    "dbMigration.imagePullPolicy"                             = "Always"
    "dbMigration.jobName"                                     = "migration-job"
    "dbMigration.version"                                     = "8"
    "dbMigration.serviceAccount"                              = "swoop-bundle"
    "dbMigration.replicaCount"                                = 1
  }
}

variable deploy_swoop_api {
  description = "Whether or not to include the SWOOP API module resources"
  type        = bool
  default     = true
}

variable deploy_swoop_caboose {
  description = "Whether or not to include the SWOOP Caboose module resources"
  type        = bool
  default     = true
}

variable deploy_db_migration {
  description = "Whether or not to include the DB Migration capability for SWOOP resources"
  type        = bool
  default     = true
}

variable deploy_argo_workflows {
  type        = bool
  default     = true
  description = "Deploy Argo Workflows"
}
