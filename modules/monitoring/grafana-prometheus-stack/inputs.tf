variable grafana_additional_data_sources {
  type = list(object({
    name = string
    type = string
    isDefault = optional(string, "no")
    access = optional(string, "proxy")
    url = string
    version = optional(number, 1)
  }))
  default = [{
      name        = "Loki"
      type        = "loki"
      isDefault   = "no"
      access      = "proxy"
      url         = "http://loki-read:3100"
      version     = 1
  }]
  description = "Additional data sources to be configured in Grafana."
}

variable grafana_service_port {
  type = number
  default = 3009
  description = "Port exposing the Grafana service. Defaults to 3009."
}
