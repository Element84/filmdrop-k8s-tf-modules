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

variable custom_minio_input_map {
  type        = map
  description = "Input values for MinIO"
}

variable custom_postgres_input_map {
  type        = map
  description = "Input values for Postgres"
}

variable custom_swoop_input_map {
  type        = map
  description = "Input values for SWOOP Bundle Helm Chart"
  default     = {
    "swoop.api.executionDir"        = "s3://swoop/execution"
    "swoop.api.configFile"          = "workflow-config.yml"
    "swoop.api.serviceAccount"      = "swoop-api"
    "swoop.caboose.configFile"      = "/opt/swoop-go/fixtures/swoop-config.yml"
    "swoop.caboose.serviceAccount"  = "argo"
    "swoop.argo.crdsInstall"        = true
    "swoop.argo.objectCounts"       = 5
    "swoop.bundle.serviceAccount"   = "swoop-bundle"
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

variable "owner_secret" {
  description = "Kubernetes Secret name of Owner credentials"
  type        = string
  sensitive   = true
}

variable "api_secret" {
  description = "Kubernetes Secret name of API credentials"
  type        = string
  sensitive   = true
}

variable "caboose_secret" {
  description = "Kubernetes Secret name of Caboose credentials"
  type        = string
  sensitive   = true
}

variable "conductor_secret" {
  description = "Kubernetes Secret name of Conductor credentials"
  type        = string
  sensitive   = true
}

variable "minio_secret" {
  description = "Object Storage Kubernetes Secret name for credentials"
  type        = string
  sensitive   = true
}

variable custom_swoop_api_service_input_map {
  type        = map
  description = "Input values for SWOOP API Helm Chart"
  default     = {
    "container.port"      = 8000
    "deployment.name"     = "swoop-api"
    "image.repository"    = "quay.io/element84/swoop"
    "image.tag"           = "latest"
    "service.type"        = "ClusterIP"
    "service.port"        = 8000
    "service.targetPort"  = 8000
    "service.name"        = "swoop-api"
    "replicaCount"        = 1
  }
}

variable custom_swoop_caboose_service_input_map {
  type        = map
  description = "Input values for SWOOP Caboose Helm Chart"
  default     = {
    "container.port"      = 8000
    "deployment.name"     = "swoop-caboose"
    "image.repository"    = "quay.io/element84/swoop-go"
    "image.tag"           = "latest"
    "service.type"        = "ClusterIP"
    "service.port"        = 8000
    "service.targetPort"  = 8000
    "service.name"        = "swoop-caboose"
    "replicaCount"        = 1
  }
}
