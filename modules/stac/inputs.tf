variable namespace_annotations {
  type = map(string)
  description = "Map of annotations applied to the created namespace"
  default = {}
}

variable deploy_stacfastapi {
  description = "Whether or not to deploy the STAC-FastAPI module resources"
  type        = bool
  default     = false
}
