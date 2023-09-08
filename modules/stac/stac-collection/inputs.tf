
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


