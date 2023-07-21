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

variable extra_values {
  type = map(string)
  description = "MAP of extra Helm values"
}

variable ingress_nginx_version {
  type = string
  description = "Version of Ingress NGINX Helm Chart"
  default = "4.7.1"
}

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "ingress-nginx"
}

variable custom_ingress_nginx_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom Ingress NGINX values.yaml"
}

variable ingress_nginx_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}
