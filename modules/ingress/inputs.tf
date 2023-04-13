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

variable deploy_ingress_nginx {
  type        = bool
  default     = true
  description = "Deploy Ingress Nginx proxy"
}

variable nginx_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the NGINX stack"
}
