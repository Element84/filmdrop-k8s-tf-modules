variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable postgres_version {
  type = string
  description = "Version of SWOOP API Helm Chart"
  default = "0.1.0"
}

variable swoop_namespace {
  description = "Name of SWOOP Namespace"
  type        = string
  default     = "swoop"
}

variable postgres_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_postgres_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom SWOOP API values.yaml"
}
