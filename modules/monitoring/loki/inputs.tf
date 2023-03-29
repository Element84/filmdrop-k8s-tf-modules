variable "loki_replicas" {
  type = number
  description = "The number of read, write, and backend replicas to deploy. Defaults to 1."
  default = 1

  validation {
    condition = var.loki_replicas >= 1 && var.loki_replicas <= 3
    error_message = "Replicas value must be greater than or equal to 1 and less than or equal to 3."
  }
}

variable "minio_enabled" {
  type = bool
  description = "Whether or not to use minio as local block storage. Defaults to true."
  default = true
}
