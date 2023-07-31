variable deploy_linkerd { 
  type        = bool
  default     = true
  description = "Mesh Applications with Linkerd"
}

variable high_availability { 
  type        = bool
  default     = false
  description = "Install Linkerd in high availability (HA) mode"
}

variable cert_validity_period_hours { 
  description = "The number of hours after initial issuing that the certificate will become invalid."
  type        = number
  default     = 8760 # 1 year
}

variable linkerd_additional_configuration_values { 
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. Example: [\"enablePodAntiAffinity: false\"]"
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

variable nginx_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the NGINX stack"
}

variable deploy_ingress_nginx { 
  type        = bool
  default     = false
  description = "Deploy Ingress Nginx proxy"
}

variable loki_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Loki stack"
}

variable grafana_prometheus_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Grafana/Prometheus stack"
}

variable grafana_additional_data_sources {
  type        = list
  description = "List of MAP specifying additional data sources for grafana, defaults to Loki data source"
}

variable promtail_extra_values {
  type        = map(string)
  description = "MAP of Helm values for the Promtail stack"

}

variable deploy_grafana_prometheus { 
  type        = bool
  default     = true
  description = "Deploy Grafana and Prometheus stack"
}

variable deploy_loki { 
  type        = bool
  default     = true
  description = "Deploy Loki stack"
}

variable deploy_promtail { 
  type        = bool
  default     = true
  description = "Deploy Promtail stack"
}

variable deploy_argo_workflows { 
  type        = bool
  default     = true
  description = "Deploy Argo Workflows"
}

variable namespace_annotations {
  type        = map(string)
  description = "MAP of custom defined namespace annotations"
}

variable deploy_titiler {
  description = "Whether or not to include the TiTiler tiling module resources"
  type        = bool
  default     = false
}

variable deploy_stacfastapi {
  description = "Whether or not to deploy the STAC-FastAPI module resources"
  type        = bool
  default     = false
}

variable deploy_swoop_api {
  description = "Whether or not to include the SWOOP API module resources"
  type        = bool
  default     = true
}

variable deploy_swoop_caboose {
  description = "Whether or not to include the SWOOP Caboose module resources"
  type        = bool
  default     = true
}

variable create_swoop_namespace {
  description = "Whether or not to include to create the SWOOP Namespace"
  type        = bool
  default     = true
}

variable swoop_namespace {
  description = "Name of SWOOP Namespace"
  type        = string
  default     = "swoop"
}

variable swoop_bundle_version {
  type = string
  description = "Version of SWOOP Bundle Helm Chart"
  default = "0.1.0"
}

variable deploy_postgres {
  description = "Whether or not to include the Postgres module resources"
  type        = bool
  default     = true
}

variable deploy_minio {
  description = "Whether or not to include the MinIO module resources"
  type        = bool
  default     = true
}

variable postgres_version {
  type = string
  description = "Version of Postgres Helm Chart"
  default = "0.1.0"
}

variable minio_version {
  type = string
  description = "Version of MinIO Helm Chart"
  default = "0.1.0"
}

variable swoop_api_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_swoop_api_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom SWOOP API values.yaml"
}

variable postgres_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_postgres_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom Postgres values.yaml"
}

variable minio_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_minio_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom MinIO values.yaml"
}

variable custom_swoop_input_map {
  type        = map
  description = "Input values for SWOOP Bundle Helm Chart"
  default     = {
    "swoop-api.swoopApi.image.repository"                     = "quay.io/element84/swoop"
    "swoop-api.swoopApi.image.tag"                            = "latest"
    "swoop-api.swoopApi.container.port"                       = 8000
    "swoop-api.swoopApi.service.type"                         = "ClusterIP"
    "swoop-api.swoopApi.service.port"                         = 8000
    "swoop-api.swoopApi.service.targetPort"                   = 8000
    "swoop-api.swoopApi.service.swoopExecutionDir"            = "s3://swoop/execution"
    "swoop-api.swoopApi.service.swoopS3Endpoint"              = "http://minio.io:9000"
    "swoop-api.swoopApi.service.swoopWorkflowConfigFile"      = "workflow-config.yml"
    "swoop-api.swoopApi.service.name"                         = "swoop-api"
    "swoop-api.swoopApi.deployment.name"                      = "swoop-api"
    "swoop-api.swoopApi.replicaCount"                         = 1
    "swoop-caboose.swoopCaboose.image.repository"             = "quay.io/element84/swoop-go"
    "swoop-caboose.swoopCaboose.image.tag"                    = "latest"
    "swoop-caboose.swoopCaboose.container.port"               = 8000
    "swoop-caboose.swoopCaboose.service.type"                 = "ClusterIP"
    "swoop-caboose.swoopCaboose.service.port"                 = 8000
    "swoop-caboose.swoopCaboose.service.targetPort"           = 8000
    "swoop-caboose.swoopCaboose.service.swoopS3Endpoint"      = "http://minio.io:9000"
    "swoop-caboose.swoopCaboose.service.swoopConfigFile"      = "/opt/swoop-go/fixtures/swoop-config.yml"
    "swoop-caboose.swoopCaboose.service.name"                 = "swoop-caboose"
    "swoop-caboose.swoopCaboose.deployment.name"              = "swoop-caboose"
    "swoop-caboose.swoopCaboose.replicaCount"                 = 1
    "swoop-caboose.swoopCaboose.argoWorkflows.objectCounts"   = 5
    "swoop-caboose.swoopCaboose.argoWorkflows.crds.install"   = true
    "swoop-caboose.swoopCaboose.argoWorkflows.serviceAccount" = "argo"
    "swoop-caboose.swoopCaboose.serviceAccount"               = "argo"
  }
}

variable custom_minio_input_map {
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
variable custom_postgres_input_map {
  type        = map
  description = "Input values for SWOOP API Helm Chart"
  default = {
    "postgres.image.repository"               = "quay.io/element84/swoop-db"
    "postgres.image.tag"                      = "latest"
    "postgres.container.port"                 = 5432
    "postgres.service.type"                   = "ClusterIP"
    "postgres.service.port"                   = 5432
    "postgres.service.targetPort"             = 5432
    "postgres.service.name"                   = "postgres"
    "postgres.service.dbName"                 = "swoop"
    "postgres.service.authMethod"             = "trust"
    "postgres.service.dbUser"                 = "cG9zdGdyZXM="
    "postgres.service.dbPassword"             = "cGFzc3dvcmQ="
    "postgres.service.sslMode"                = "disable"
    "postgres.deployment.schemaVersionTable"  = "swoop.schema_version"
    "postgres.replicaCount"                   = 1
  }
}

variable minio_namespace {
  type        = string
  description = "Namespace for MinIO"
  default     = "io"
}

variable postgres_namespace {
  type        = string
  description = "Namespace for Postgres"
  default     = "db"
}

variable create_ingress_nginx_namespace {
  description = "Whether or not to include to create the Ingress NGINX Namespace"
  type        = bool
  default     = true
}

variable ingress_nginx_namespace {
  description = "Name of Ingress NGINX Namespace"
  type        = string
  default     = "ingress-nginx"
}

variable ingress_nginx_additional_configuration_values {
  type        = list(string)
  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

variable custom_ingress_nginx_values_yaml {
  type        = string
  default     = ""
  description = "Path to custom MinIO values.yaml"
}

variable ingress_nginx_version {
  type = string
  description = "Version of Ingress NGINX Helm Chart"
  default = "4.7.1"
}
