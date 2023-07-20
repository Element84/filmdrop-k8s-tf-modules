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

variable create_namespace {
  description = "Whether or not to include to create the namespace"
  type        = bool
  default     = true
}

variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable ingress_nginx_version {
  type = string
  description = "Version of Ingress NGINX Helm Chart"
  default = "4.5.2"
}

variable namespace {
  description = "Name of namespace"
  type        = string
  default     = "ingress-nginx"
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
