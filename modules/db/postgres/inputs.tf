variable "postgres_version" {
  type        = string
  description = "Version of Postgres Helm Chart"
  default     = "0.1.0"
}

variable "namespace" {
  description = "Name of namespace"
  type        = string
  default     = "db"
}

variable "postgres_additional_configuration_values" {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable "custom_postgres_values_yaml" {
  type        = string
  default     = ""
  description = "Path to custom Postgres values.yaml"
}

variable "custom_input_map" {
  type        = map(any)
  description = "Input values for Postgres Helm Chart"
  default = {
    "postgres.image.repository"              = "quay.io/element84/swoop-db"
    "postgres.image.tag"                     = "latest"
    "postgres.container.port"                = 5432
    "postgres.service.type"                  = "ClusterIP"
    "postgres.service.port"                  = 5432
    "postgres.service.targetPort"            = 5432
    "postgres.service.name"                  = "postgres"
    "postgres.service.dbName"                = "swoop"
    "postgres.service.authMethod"            = "trust"
    "postgres.service.dbUser"                = "cG9zdGdyZXM="
    "postgres.service.dbPassword"            = "cGFzc3dvcmQ="
    "postgres.service.sslMode"               = "disable"
    "postgres.deployment.schemaVersionTable" = "swoop.schema_version"
    "postgres.replicaCount"                  = 1
  }
}

variable "postgres_default_username" {
  description = "Default username for Postgres"
  type        = string
  default     = "cG9zdGdyZXM="
}

variable "postgres_default_password" {
  description = "Default password for Postgres"
  type        = string
  default     = "cGFzc3dvcmQ="
}

variable "owner_username" {
  description = "Username for Owner role"
  type        = string
  default     = "dXNlcl9vd25lcg=="
}

variable "owner_password" {
  description = "Password for Owner role"
  type        = string
  default     = "cGFzc19vd25lcg=="
}

variable "api_username" {
  description = "Username for API role"
  type        = string
  default     = "dXNlcl9hcGk="
}

variable "api_password" {
  description = "Password for API role"
  type        = string
  default     = "cGFzc19hcGk="
}

variable "caboose_username" {
  description = "Username for Caboose role"
  type        = string
  default     = "dXNlcl9jYWJvb3Nl"
}

variable "caboose_password" {
  description = "Password for Caboose role"
  type        = string
  default     = "cGFzc19jYWJvb3Nl"
}

variable "conductor_username" {
  description = "Username for Conductor role"
  type        = string
  default     = "dXNlcl9jb25kdWN0b3I="
}

variable "conductor_password" {
  description = "Password for Conductor role"
  type        = string
  default     = "cGFzc19jb25kdWN0b3I="
}
