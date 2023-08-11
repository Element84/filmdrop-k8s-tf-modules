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

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "db"
}
