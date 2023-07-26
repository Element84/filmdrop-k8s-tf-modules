variable namespace_annotations {
  type = map(string)
  description = "MAP of annotations applied to the created namespace"
  default = {}
}

variable minio_version {
  type = string
  description = "Version of SWOOP Bundle Helm Chart"
  default = "0.1.0"
}

variable namespace {
  description = "Name of MinIO Namespace"
  type        = string
  default     = "io"
}

variable minio_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_minio_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom SWOOP API values.yaml"
}

variable custom_input_map {
  type        = map
  description = "Input values for MinIO Helm Chart"
  default = {
    "minio.image.repository"          = "quay.io/minio/minio"
    "minio.image.tag"                 = "latest"
    "minio.container.port"            = 9000
    "minio.container.servicePort"     = 9001
    "minio.service.type"              = "ClusterIP"
    "minio.service.port"              = 9000
    "minio.service.targetPort"        = 9000
    "minio.service.servicePort"       = 9001
    "minio.service.serviceTargetPort" = 9001
    "minio.service.name"              = "minio"
    "minio.service.bucketName"        = "swoop"
    "minio.service.accessKeyId"       = "bWluaW8="
    "minio.service.secretAccessKey"   = "cGFzc3dvcmQ="
    "minio.deployment.name"           = "minio"
    "minio.replicaCount"              = 1
  }
}
