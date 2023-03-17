variable "use_linkerd_mesh" {
  type        = bool
  default     = true
  description = "Mesh Applications with Linkerd"
}

variable "high_availability" {
  type        = bool
  default     = false
  description = "Install Linkerd in high availability (HA) mode"
}

variable "ingress_controller" {
  description = "Type of Ingress Controller."
  type        = string
  default     = "nginx"
}

variable "cert_validity_period_hours" {
  description = "The number of hours after initial issuing that the certificate will become invalid."
  type        = number
  default     = 8760 # 1 year
}

variable "linkerd_additional_configuration_values" {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. Example: [\"enablePodAntiAffinity: false\"]"
}

variable "kubernetes_config_file" {
  description = "Kubernetes config file path."
  type        = string
  default     = "~/.kube/config"
}

variable "kubernetes_config_context" {
  description = "Kubernetes config context."
  type        = string
  default     = ""
}

variable "local_or_eks" {
  description = "local or EKS deployment"
  type        = string
  default     = "local"
}
