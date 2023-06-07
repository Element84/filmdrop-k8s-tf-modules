variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable namespace {
  description = "Name of Namespace"
  type        = string
}

variable create_namespace {
  description = "Whether or not to include to create the Namespace"
  type        = bool
  default     = true
}
