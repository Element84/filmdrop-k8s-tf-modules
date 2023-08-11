variable create_namespace {
  description = "Whether or not to include to create the namespace"
  type        = bool
  default     = true
}

variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
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

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "db"
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

variable custom_postgres_input_map {
  type        = map
  description = "Input values for Postgres Helm Chart"
  default = {
    "container.port"                      = 5432
    "deployment.name"                     = "postgres"
    "image.repository"                    = "quay.io/element84/swoop-db"
    "image.tag"                           = "latest"
    "migration.imagePullPolicy"           = "Always"
    "migration.jobName"                   = "migration-job"
    "migration.version"                   = 8
    "migration.no_wait"                   = false
    "migration.rollback"                  = false
    "migration.image.repository"          = "quay.io/element84/swoop-db"
    "migration.image.tag"                 = "latest"
    "replicaCount"                        = 1
    "service.type"                        = "ClusterIP"
    "service.port"                        = 5432
    "service.targetPort"                  = 5432
    "service.name"                        = "postgres"
    "service.dbName"                      = "swoop"
    "service.authMethod"                  = "trust"
    "service.createDBAdminSecret"         = false
    "service.dbUser"                      = ""
    "service.dbPassword"                  = ""
    "service.createOwnerRoleSecret"       = false
    "service.ownerRoleUsername"           = ""
    "service.ownerRolePassword"           = ""
    "service.createApiRoleSecret"         = false
    "service.apiRoleUsername"             = ""
    "service.apiRolePassword"             = ""
    "service.createCabooseRoleSecret"     = false
    "service.cabooseRoleUsername"         = ""
    "service.cabooseRolePassword"         = ""
    "service.createConductorRoleSecret"   = false
    "service.conductorRoleUsername"       = ""
    "service.conductorRolePassword"       = ""
    "service.sslMode"                     = "disable"
    "service.schemaVersionTable"          = "swoop.schema_version"
    "storage.size"                        = "1Gi"
    "storage.volumeBindingMode"           = "WaitForFirstConsumer"
    "storage.provisioner"                 = "filmdrop.io/local-path-provisioner"
    "storage.retainPersistentVolume"      = true
    "storage.storageClassName"            = "postgres-retain"
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

variable deploy_db_migration {
  description = "Whether or not to include the DB Migration capability for SWOOP resources"
  type        = bool
  default     = true
}
