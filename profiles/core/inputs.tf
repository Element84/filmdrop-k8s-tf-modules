variable deploy_linkerd { 
  type        = bool
  default     = true
  description = "Mesh Applications with Linkerd"
}

variable high_availability { 
  type        = bool
  default     = false
  description = "Install Linkerd in high availability (HA) mode"
}

variable cert_validity_period_hours { 
  description = "The number of hours after initial issuing that the certificate will become invalid."
  type        = number
  default     = 8760 # 1 year
}

variable linkerd_additional_configuration_values { 
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. Example: [\"enablePodAntiAffinity: false\"]"
}

variable kubernetes_config_file { 
  description = "Kubernetes config file path."
  type        = string
  default     = "~/.kube/config"
}

variable kubernetes_config_context { 
  description = "Kubernetes config context."
  type        = string
  default     = ""
}

variable nginx_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the NGINX stack"
}

variable deploy_ingress_nginx { 
  type        = bool
  default     = false
  description = "Deploy Ingress Nginx proxy"
}

variable loki_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Loki stack"
}

variable grafana_prometheus_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Grafana/Prometheus stack"
}

variable grafana_additional_data_sources {
  type        = list
  description = "List of MAP specifying additional data sources for grafana, defaults to Loki data source"
}

variable promtail_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Promtail stack"

}

variable deploy_grafana_prometheus { 
  type        = bool
  default     = true
  description = "Deploy Grafana and Prometheus stack"
}

variable deploy_loki { 
  type        = bool
  default     = true
  description = "Deploy Loki stack"
}

variable deploy_promtail { 
  type        = bool
  default     = true
  description = "Deploy Promtail stack"
}

variable deploy_argo_workflows { 
  type        = bool
  default     = true
  description = "Deploy Argo Workflows"
}

variable namespace_annotations {
  type        = map(string)
  description = "MAP of custom defined namespace annotations"
}

variable deploy_titiler {
  description = "Whether or not to include the TiTiler tiling module resources"
  type        = bool
  default     = false
}

variable deploy_stacfastapi {
  description = "Whether or not to deploy the STAC-FastAPI module resources"
  type        = bool
  default     = false
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

variable swoop_bundle_version {
  type = string
  description = "Version of SWOOP Bundle Helm Chart"
  default = "0.1.0"
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

variable postgres_version {
  type = string
  description = "Version of Postgres Helm Chart"
  default = "0.1.0"
}

variable db_init_version {
  type        = string
  description = "Version of DB Init Helm Chart"
  default     = "0.1.0"
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

variable custom_minio_input_map {
  type        = map
  description = "Input values for MinIO Helm Chart"
  default = {
    "container.port"                                      = 9000
    "container.servicePort"                               = 9001
    "deployment.name"                                     = "minio"
    "image.repository"                                    = "quay.io/minio/minio"
    "image.tag"                                           = "latest"
    "local-path-provisioner.enabled"                      = true
    "local-path-provisioner.storageClass.provisionerName" = "filmdrop.io/local-minio-path-provisioner"
    "local-path-provisioner.storageClass.name"            = "local-path-class-minio"
    "replicaCount"                                        = 1
    "service.type"                                        = "ClusterIP"
    "service.port"                                        = 9000
    "service.targetPort"                                  = 9000
    "service.servicePort"                                 = 9001
    "service.serviceTargetPort"                           = 9001
    "service.name"                                        = "minio"
    "service.bucketName"                                  = "swoop"
    "service.accessKeyId"                                 = ""
    "service.secretAccessKey"                             = ""
    "service.createSecret"                                = false
    "storage.size"                                        = "256M"
    "storage.volumeBindingMode"                           = "WaitForFirstConsumer"
    "storage.provisioner"                                 = "filmdrop.io/local-minio-path-provisioner"
    "storage.retainPersistentVolume"                      = true
    "storage.storageClassName"                            = "minio-retain"
  }
}

variable custom_postgres_input_map {
  type        = map
  description = "Input values for Postgres Helm Chart"
  default = {
    "container.port"                                      = 5432
    "deployment.name"                                     = "postgres"
    "image.repository"                                    = "quay.io/element84/swoop-db"
    "image.tag"                                           = "latest"
    "local-path-provisioner.enabled"                      = true
    "local-path-provisioner.storageClass.provisionerName" = "filmdrop.io/local-path-provisioner"
    "local-path-provisioner.storageClass.name"            = "local-path-class-postgres"
    "migration.imagePullPolicy"                           = "Always"
    "migration.jobName"                                   = "migration-job"
    "migration.version"                                   = 8
    "migration.no_wait"                                   = false
    "migration.rollback"                                  = false
    "migration.image.repository"                          = "quay.io/element84/swoop-db"
    "migration.image.tag"                                 = "latest"
    "replicaCount"                                        = 1
    "service.type"                                        = "ClusterIP"
    "service.port"                                        = 5432
    "service.targetPort"                                  = 5432
    "service.name"                                        = "postgres"
    "service.dbName"                                      = "swoop"
    "service.authMethod"                                  = "trust"
    "service.createDBAdminSecret"                         = false
    "service.dbUser"                                      = ""
    "service.dbPassword"                                  = ""
    "service.createOwnerRoleSecret"                       = false
    "service.ownerRoleUsername"                           = ""
    "service.ownerRolePassword"                           = ""
    "service.createApiRoleSecret"                         = false
    "service.apiRoleUsername"                             = ""
    "service.apiRolePassword"                             = ""
    "service.createCabooseRoleSecret"                     = false
    "service.cabooseRoleUsername"                         = ""
    "service.cabooseRolePassword"                         = ""
    "service.createConductorRoleSecret"                   = false
    "service.conductorRoleUsername"                       = ""
    "service.conductorRolePassword"                       = ""
    "service.sslMode"                                     = "disable"
    "service.schemaVersionTable"                          = "swoop.schema_version"
    "storage.size"                                        = "256M"
    "storage.volumeBindingMode"                           = "WaitForFirstConsumer"
    "storage.provisioner"                                 = "filmdrop.io/local-path-provisioner"
    "storage.retainPersistentVolume"                      = true
    "storage.storageClassName"                            = "postgres-retain"
  }
}

variable "dbadmin_username" {
  description = "DB Admin username"
  type        = string
  default     = ""
  sensitive   = true
}

variable "dbadmin_password" {
  description = "Password for DB Admin"
  type        = string
  default     = ""
  sensitive   = true
}

variable "dbadmin_secret" {
  description = "Kubernetes Secret name of DB Admin credentials"
  type        = string
  default     = "postgres-secret-admin-role"
  sensitive   = true
}

variable "owner_username" {
  description = "Username for Owner role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "owner_password" {
  description = "Password for Owner role"
  type        = string
  default     = ""
}

variable "owner_secret" {
  description = "Kubernetes Secret name of Owner credentials"
  type        = string
  default     = "postgres-secret-owner-role"
  sensitive   = true
}

variable "api_username" {
  description = "Username for API role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "api_password" {
  description = "Password for API role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "api_secret" {
  description = "Kubernetes Secret name of API credentials"
  type        = string
  default     = "postgres-secret-api-role"
  sensitive   = true
}

variable "caboose_username" {
  description = "Username for Caboose role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "caboose_password" {
  description = "Password for Caboose role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "caboose_secret" {
  description = "Kubernetes Secret name of Caboose credentials"
  type        = string
  default     = "postgres-secret-caboose-role"
  sensitive   = true
}

variable "conductor_username" {
  description = "Username for Conductor role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "conductor_password" {
  description = "Password for Conductor role"
  type        = string
  default     = ""
  sensitive   = true
}

variable "conductor_secret" {
  description = "Kubernetes Secret name of Conductor credentials"
  type        = string
  default     = "postgres-secret-conductor-role"
  sensitive   = true
}


variable "minio_access_key" {
  description = "Object Storage accessKeyId credential"
  type        = string
  default     = ""
  sensitive   = true
}

variable "minio_secret_access_key" {
  description = "Object Storage secretAccessKey credential"
  type        = string
  default     = ""
  sensitive   = true
}

variable "minio_secret" {
  description = "Object Storage Kubernetes Secret name for credentials"
  type        = string
  default     = "minio-secret-credentials"
  sensitive   = true
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

variable create_ingress_nginx_namespace {
  description = "Whether or not to include to create the Ingress NGINX Namespace"
  type        = bool
  default     = true
}

variable ingress_nginx_namespace {
  description = "Name of Ingress NGINX Namespace"
  type        = string
  default     = "ingress-nginx"
}

variable ingress_nginx_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_ingress_nginx_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom MinIO values.yaml"
}

variable ingress_nginx_version {
  type = string
  description = "Version of Ingress NGINX Helm Chart"
  default = "4.7.1"
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

variable stac_namespace {
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
