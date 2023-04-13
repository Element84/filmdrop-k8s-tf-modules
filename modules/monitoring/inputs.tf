variable loki_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Loki stack"
}

variable grafana_prometheus_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Grafana/Prometheus stack"
}

variable grafana_additional_data_sources {
  type        = list
  description = "List of MAP specifying additional data sources for grafana, defaults to Loki data source"
}

variable promtail_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Promtail stack"
}

variable deploy_grafana_prometheus {
  type        = bool
  default     = true
  description = "Deploy Grafana and Prometheus stack"
}

variable deploy_loki {
  type        = bool
  default     = true
  description = "Deploy Loki stack"
}

variable deploy_promtail {
  type        = bool
  default     = true
  description = "Deploy Promtail stack"
}
