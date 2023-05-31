variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable deploy_swoop_api {
  description = "Whether or not to include the SWOOP API module resources"
  type        = bool
  default     = true
}

variable swoop_api_version {
  type = string
  description = "Version of SWOOP API Helm Chart"
  default = "0.0.1"
}
