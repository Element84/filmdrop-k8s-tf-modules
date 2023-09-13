
variable deploy_staccollection{
  description = "Whether or not to deploy the STAC-collection module resources"
  type        = bool
  default     = false
}

variable namespace {
  type        = string
  description = "Namespace for STAC-FastAPI"
  default     = "stac"
}

variable fastapi_servicename {
  description = "STAC FastAPI Service Name"
  type        = string
  default     = "stac-fastapi-pgstac"
}

variable fastapi_serviceport {
  description = "STAC FastAPI Service Port"
  type        = number
  default     = 8080
}

variable fastapi_serviceaccountname {
  description = "STAC FastAPI Service Account Name"
  type        = string
  default     = "stac-fastapi-pgstac"
}
