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
