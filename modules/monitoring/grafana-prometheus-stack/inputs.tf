variable grafana_additional_data_sources {
  type = list(object({
    name = string
    type = string
    isDefault = optional(string, "no")
    access = optional(string, "proxy")
    url = string
    version = optional(number, 1)
  }))
  description = "Additional data sources to be configured in Grafana."
}

variable extra_values {
  type = map(string)
  description = "MAP of extra Helm values"
}

variable namespace {
  description = "Name of monitoring namespace"
  type        = string
  default     = "monitoring"
}