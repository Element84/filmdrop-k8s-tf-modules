variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable swoop_api_version {
  type = string
  description = "Version of SWOOP API Helm Chart"
  default = "0.0.1"
}
