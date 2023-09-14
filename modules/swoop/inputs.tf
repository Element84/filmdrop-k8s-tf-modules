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

variable deploy_swoop_caboose {
  description = "Whether or not to include the SWOOP Caboose module resources"
  type        = bool
  default     = true
}

variable deploy_swoop_conductor {
  description = "Whether or not to include the SWOOP Conductor module resources"
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

variable create_namespace {
  description = "Whether or not to include to create the namespace"
  type        = bool
  default     = true
}

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "swoop"
}

variable swoop_bundle_version {
  type = string
  description = "Version of SWOOP Bundle Helm Chart"
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

variable custom_minio_input_map {
  type        = map
  description = "Input values for MinIO"
}

variable custom_postgres_input_map {
  type        = map
  description = "Input values for Postgres"
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

variable custom_swoop_input_map {
  type        = map(any)
  description = "Input values for SWOOP Bundle Helm Chart"
  default = {
    "swoop.api.executionDir"            = "s3://swoop/execution"
    "swoop.api.configFile"              = "workflow-config.yml"
    "swoop.api.serviceAccount"          = "swoop-api"
    "swoop.caboose.configFile"          = "/opt/swoop-go/fixtures/swoop-config.yml"
    "swoop.caboose.serviceAccount"      = "argo"
    "swoop.caboose.argo.crdsInstall"    = true
    "swoop.caboose.argo.objectCounts"   = 5
    "swoop.conductor.configFile"        = "/opt/swoop-go/fixtures/swoop-config.yml"
    "swoop.conductor.serviceAccount"    = "argo"
    "swoop.conductor.argo.enabled"      = false
    "swoop.conductor.argo.crdsInstall"  = false
    "swoop.conductor.argo.objectCounts" = 5
    "swoop.conductor.instanceName"      = "main"
    "swoop.bundle.serviceAccount"       = "swoop-bundle"
  }
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

variable custom_swoop_conductor_service_input_map {
  type        = map(any)
  description = "Input values for SWOOP Conductor Helm Chart"
  default = {
    "container.port"     = 8000
    "deployment.name"    = "swoop-conductor"
    "image.repository"   = "quay.io/element84/swoop-go"
    "image.tag"          = "latest"
    "service.type"       = "ClusterIP"
    "service.port"       = 8000
    "service.targetPort" = 8000
    "service.name"       = "swoop-conductor"
    "replicaCount"       = 1
  }
}

variable deploy_postgres {
  description = "Whether or not to include the Postgres module resources"
  type        = bool
  default     = true
}

variable deploy_db_init {
  description = "Whether or not to deploy the Postgres initialization script"
  type        = bool
  default     = true
}

variable deploy_minio {
  description = "Whether or not to include the MinIO module resources"
  type        = bool
  default     = true
}

variable swoop_sa_iam_role {
  type          = string
  description   = "IAM Role for SWOOP Service Account"
  default       = ""
  sensitive     = true
}

variable custom_stac_fastapi_input_map {
  type        = map
  description = "Input values for STAC-FastAPI Helm Chart"
  default = {
    "local-path-provisioner.enabled"                      = true
    "local-path-provisioner.singleNamespace"              = false
    "local-path-provisioner.storageClass.provisionerName" = "filmdrop.io/local-pgstac-path-provisioner"
    "local-path-provisioner.storageClass.name"            = "local-path-class-pgstac"
    "local-path-provisioner.configmap.name"               = "local-path-config-pgstac"
    "pgStac.container.port"                               = 5432
    "pgStac.deployment.name"                              = "pgstac"
    "pgStac.image.repository"                             = "quay.io/element84/pgstac"
    "pgStac.image.tag"                                    = "latest"
    "pgStac.enabled"                                      = true
    "pgStac.replicaCount"                                 = 1
    "pgStac.service.type"                                 = "ClusterIP"
    "pgStac.service.port"                                 = 5439
    "pgStac.service.targetPort"                           = 5432
    "pgStac.service.name"                                 = "pgstac"
    "pgStac.dbName"                                       = "postgis"
    "pgStac.dbHost"                                       = ""
    "pgStac.dbUser"                                       = ""
    "pgStac.dbPassword"                                   = ""
    "pgStac.createPgStacSecret"                           = false
    "pgStac.storage.size"                                 = "256M"
    "pgStac.storage.volumeBindingMode"                    = "WaitForFirstConsumer"
    "pgStac.storage.provisioner"                          = "filmdrop.io/local-pgstac-path-provisioner"
    "pgStac.storage.retainPersistentVolume"               = true
    "pgStac.storage.storageClassName"                     = "pgstac-retain"
    "stacFastApi.container.port"                          = 8080
    "stacFastApi.deployment.name"                         = "stac-fastapi-pgstac"
    "stacFastApi.image.repository"                        = "ghcr.io/stac-utils/stac-fastapi-pgstac"
    "stacFastApi.image.tag"                               = "main"
    "stacFastApi.replicaCount"                            = 1
    "stacFastApi.service.type"                            = "ClusterIP"
    "stacFastApi.service.port"                            = 8080
    "stacFastApi.service.targetPort"                      = 8080
    "stacFastApi.service.name"                            = "stac-fastapi-pgstac"
    "stacFastApi.service.serviceserviceAccount"           = "stac-fastapi-pgstac"
  }
}

variable stac_namespace {
  type        = string
  description = "Namespace for STAC-FastAPI"
  default     = "stac"
}
