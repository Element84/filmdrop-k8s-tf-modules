variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable deploy_titiler {
  description = "Whether or not to include the titiler tiling module resources"
  type        = bool
  default     = true
}
