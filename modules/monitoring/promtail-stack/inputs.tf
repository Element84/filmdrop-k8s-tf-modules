variable extra_values {
  type = map(string)
  description = "MAP of extra Helm values"
}

variable namespace {
  description = "Name of monitoring namespace"
  type        = string
  default     = "monitoring"
}