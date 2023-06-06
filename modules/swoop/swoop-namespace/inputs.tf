variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable swoop_namespace {
  description = "Name of SWOOP Namespace"
  type        = string
  default     = "swoop"
}

variable create_swoop_namespace {
  description = "Whether or not to include to create the SWOOP Namespace"
  type        = bool
  default     = true
}
