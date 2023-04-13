variable deploy_linkerd { 
  type        = bool
  default     = true
  description = "Mesh Applications with Linkerd"
}

variable high_availability { 
  type        = bool
  default     = false
  description = "Install Linkerd in high availability (HA) mode"
}

variable cert_validity_period_hours { 
  description = "The number of hours after initial issuing that the certificate will become invalid."
  type        = number
  default     = 8760 # 1 year
}

variable linkerd_additional_configuration_values { 
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. Example: [\"enablePodAntiAffinity: false\"]"
}

variable kubernetes_config_file { 
  description = "Kubernetes config file path."
  type        = string
  default     = "~/.kube/config"
}

variable kubernetes_config_context { 
  description = "Kubernetes config context."
  type        = string
  default     = ""
}

variable nginx_http_port { 
  description = "Port number for Nginx nodeport HTTP binding"
  type        = string
  default     = ""
}

variable nginx_https_port { 
  description = "Port number for Nginx nodeport HTTPS binding"
  type        = string
  default     = ""
}

variable nginx_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the NGINX stack"
}

variable deploy_ingress_nginx { 
  type        = bool
  default     = false
  description = "Deploy Ingress Nginx proxy"
}

variable deploy_hello_world { 
  type        = bool
  default     = false
  description = "Deploy Hello World app"
}

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

variable deploy_argo_workflows { 
  type        = bool
  default     = true
  description = "Deploy Argo Workflows"
}

variable deploy_argo_events { 
  type        = bool
  default     = false
  description = "Deploy Argo Events"
}

variable namespace_annotations {
  type        = map(string)
  description = "MAP of custom defined namespace annotations"
}
