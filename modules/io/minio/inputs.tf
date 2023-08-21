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

variable custom_minio_input_map {
  type        = map
  description = "Input values for MinIO Helm Chart"
  default = {
    "container.port"                                      = 9000
    "container.servicePort"                               = 9001
    "deployment.name"                                     = "minio"
    "image.repository"                                    = "quay.io/minio/minio"
    "image.tag"                                           = "latest"
    "local-path-provisioner.enabled"                      = true
    "local-path-provisioner.singleNamespace"              = false
    "local-path-provisioner.storageClass.provisionerName" = "filmdrop.io/local-minio-path-provisioner"
    "local-path-provisioner.storageClass.name"            = "local-path-class-minio"
    "local-path-provisioner.configmap.name"               = "local-path-config-minio"
    "replicaCount"                                        = 1
    "service.type"                                        = "ClusterIP"
    "service.port"                                        = 9000
    "service.targetPort"                                  = 9000
    "service.servicePort"                                 = 9001
    "service.serviceTargetPort"                           = 9001
    "service.name"                                        = "minio"
    "service.bucketName"                                  = "swoop"
    "service.accessKeyId"                                 = ""
    "service.secretAccessKey"                             = ""
    "service.createSecret"                                = false
    "storage.size"                                        = "256M"
    "storage.volumeBindingMode"                           = "WaitForFirstConsumer"
    "storage.provisioner"                                 = "filmdrop.io/local-minio-path-provisioner"
    "storage.retainPersistentVolume"                      = true
    "storage.storageClassName"                            = "minio-retain"
  }
}

variable "minio_secret" {
  description = "Object Storage Kubernetes Secret name for credentials"
  type        = string
  default     = "minio-secret-credentials"
  sensitive   = true
}
