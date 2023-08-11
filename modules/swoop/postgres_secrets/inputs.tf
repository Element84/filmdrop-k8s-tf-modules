variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "swoop"
}

variable postgres_namespace {
  type        = string
  description = "Namespace for Postgres"
  default     = "db"
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
