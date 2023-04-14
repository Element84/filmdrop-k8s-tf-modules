variable loki_replicas {
  type = number
  description = "The number of read, write, and backend replicas to deploy. Defaults to 1."
  default = 1

  validation {
    condition = var.loki_replicas >= 1 && var.loki_replicas <= 3
    error_message = "Replicas value must be greater than or equal to 1 and less than or equal to 3."
  }
}

variable loki_auth_enabled {
  type = bool
  description = "Whether or not authentication is required for the Loki server. Defaults to false."
  default = false
}

variable extra_values {
  type = map(string)
  description = "MAP of extra Helm values"
}
