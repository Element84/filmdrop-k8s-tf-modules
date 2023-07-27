resource "helm_release" "swoop_bundle" {
  name = "swoop-bundle"
  namespace = var.namespace
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart = "swoop-bundle"
  version = var.swoop_bundle_version
  atomic = true
  create_namespace = false

  set {
    name  = "swoop-api.enabled"
    value = var.deploy_swoop_api
  }

  set {
    name  = "swoop-api.postgres.service.name"
    value = "${var.custom_postgres_settings["postgres"]["service"]["name"]}.${var.postgres_namespace}"
  }

  set {
    name  = "swoop-api.postgres.service.dbName"
    value = var.custom_postgres_settings["postgres"]["service"]["dbName"]
  }

  set {
    name  = "swoop-api.postgres.service.dbUser"
    value = var.custom_postgres_settings["postgres"]["service"]["dbUser"]
  }

  set {
    name  = "swoop-api.postgres.service.dbPassword"
    value = var.custom_postgres_settings["postgres"]["service"]["dbPassword"]
  }

  set {
    name  = "swoop-api.postgres.service.sslMode"
    value = var.custom_postgres_settings["postgres"]["service"]["sslMode"]
  }

  set {
    name  = "swoop-api.postgres.service.sslMode"
    value = var.custom_postgres_settings["postgres"]["service"]["sslMode"]
  }

  set {
    name  = "swoop-api.postgres.service.authMethod"
    value = var.custom_postgres_settings["postgres"]["service"]["authMethod"]
  }

  set {
    name  = "swoop-api.postgres.service.schemaVersionTable"
    value = var.custom_postgres_settings["postgres"]["deployment"]["schemaVersionTable"]
  }

  set {
    name  = "swoop-api.minio.service.name"
    value = var.custom_minio_settings["minio"]["service"]["name"]
  }

  set {
    name  = "swoop-api.minio.service.bucketName"
    value = var.custom_minio_settings["minio"]["service"]["bucketName"]
  }

  set {
    name  = "swoop-api.minio.service.accessKeyId"
    value = var.custom_minio_settings["minio"]["service"]["accessKeyId"]
  }

  set {
    name  = "swoop-api.minio.service.secretAccessKey"
    value = var.custom_minio_settings["minio"]["service"]["secretAccessKey"]
  }

  dynamic "set" {
    for_each = var.custom_input_map

    content {
      name = set.key
      value = set.value
    }
  }

  values = concat(
    [var.custom_swoop_api_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_swoop_api_values_yaml)],
    length(var.swoop_api_additional_configuration_values) == 0 ? [] : var.swoop_api_additional_configuration_values
  )
}
