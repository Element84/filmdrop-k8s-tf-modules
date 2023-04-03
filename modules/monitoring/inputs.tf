variable loki_extra_values {
  type = map(string)
  description = "MAP of Helm values for the Loki stack"
}

variable grafana_prometheus_extra_values {
  type = map(string)
  description = "MAP of Helm values for the Grafana/Prometheus stack"
}

variable promtail_extra_values {
  type = map(string)
  description = "MAP of Helm values for the Promtail stack"
}
