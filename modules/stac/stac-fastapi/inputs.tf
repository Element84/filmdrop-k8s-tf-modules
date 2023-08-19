
variable deploy_stacfastapi {
  description = "Whether or not to deploy the STAC-FastAPI module resources"
  type        = bool
  default     = false
}

variable custom_stac_fastapi_input_map {
  type        = map
  description = "Input values for STAC-FastAPI Helm Chart"
  default = {
    "local-path-provisioner.enabled"                      = true
    "local-path-provisioner.storageClass.provisionerName" = "filmdrop.io/local-pgstac-path-provisioner"
    "local-path-provisioner.storageClass.name"            = "local-path-class-pgstac"
    "pgStac.container.port"                               = 5432
    "pgStac.deployment.name"                              = "pgstac"
    "pgStac.image.repository"                             = "ghcr.io/stac-utils/pgstac"
    "pgStac.image.tag"                                    = "v0.7.10"
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

variable "stac_fastapi_username" {
  description = "Username for STAC-FastAPI role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "stac_fastapi_password" {
  description = "Password for STAC-FastAPI role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "stac_fastapi_secret" {
  description = "Kubernetes Secret name of STAC-FastAPI credentials"
  type        = string
  default     = "stac-fastapi-secret-credentials"
  sensitive   = true
}

variable namespace {
  type        = string
  description = "Namespace for STAC-FastAPI"
  default     = "stac"
}

variable stac_version {
  type = string
  description = "Version of STAC-FastAPI Helm Chart"
  default = "0.1.0"
}

variable stac_fastapi_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_stac_fastapi_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom STAC-FastAPI values.yaml"
}
