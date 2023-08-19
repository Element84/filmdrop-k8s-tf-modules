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
