variable deploy_argo_workflows {
  type        = bool
  default     = true
  description = "Deploy Argo Workflows"
}

variable deploy_argo_events {
  type        = bool
  default     = true
  description = "Deploy Argo Events"
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

variable namespace_annotations {
  type        = map(string)
  description = "MAP of custom defined namespace annotations"
}
