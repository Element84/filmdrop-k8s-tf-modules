resource "helm_release" "swoop_bundle" {
  name = "swoop-bundle"
  namespace = var.namespace
  repository = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart = "swoop-bundle"
  version = var.swoop_bundle_version
  atomic = true
  create_namespace = false


  set {
    name  = "dbMigration.namespace"
    value = var.namespace
  }

  set {
    name  = "dbMigration.enabled"
    value = var.deploy_db_migration
  }

  set {
    name  = "postgres.service.port"
    value = var.custom_postgres_settings["postgres"]["service"]["port"]
  }

  set {
    name  = "postgres.service.name"
    value = var.custom_postgres_settings["postgres"]["service"]["name"]
  }

  set {
    name  = "postgres.service.dbNamespace"
    value = var.postgres_namespace
  }

  set {
    name  = "postgres.service.dbName"
    value = var.custom_postgres_settings["postgres"]["service"]["dbName"]
  }

  set {
    name  = "postgres.service.migrationRole"
    value = "user_owner"
  }

  set {
    name  = "swoop-api.enabled"
    value = var.deploy_swoop_api
  }

  set {
    name  = "swoop-api.swoopApi.namespace"
    value = var.namespace
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
    name  = "swoop-api.postgres.migration.enabled"
    value = var.deploy_db_migration
  }

  set {
    name  = "swoop-api.postgres.migration.imagePullPolicy"
    value = var.custom_input_map["dbMigration.imagePullPolicy"]
  }

  set {
    name  = "swoop-api.postgres.migration.jobName"
    value = var.custom_input_map["dbMigration.jobName"]
  }

  set {
    name  = "swoop-api.postgres.migration.version"
    value = var.custom_input_map["dbMigration.version"]
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

  set {
    name  = "swoop-caboose.enabled"
    value = var.deploy_swoop_caboose || var.deploy_argo_workflows
  }

  set {
    name  = "swoop-caboose.argo-workflows.enabled"
    value = var.deploy_argo_workflows
  }

  set {
    name  = "swoop-caboose.argoWorkflows.enabled"
    value = var.deploy_argo_workflows
  }

  set {
    name  = "swoop-caboose.swoopCaboose.enabled"
    value = var.deploy_swoop_caboose
  }

  set {
    name  = "swoop-caboose.swoopCaboose.namespace"
    value = var.namespace
  }

  set {
    name  = "swoop-caboose.postgres.service.name"
    value = "${var.custom_postgres_settings["postgres"]["service"]["name"]}.${var.postgres_namespace}"
  }

  set {
    name  = "swoop-caboose.postgres.service.dbName"
    value = var.custom_postgres_settings["postgres"]["service"]["dbName"]
  }

  set {
    name  = "swoop-caboose.postgres.service.dbUser"
    value = var.custom_postgres_settings["postgres"]["service"]["dbUser"]
  }

  set {
    name  = "swoop-caboose.postgres.service.dbPassword"
    value = var.custom_postgres_settings["postgres"]["service"]["dbPassword"]
  }

  set {
    name  = "swoop-caboose.postgres.service.sslMode"
    value = var.custom_postgres_settings["postgres"]["service"]["sslMode"]
  }

  set {
    name  = "swoop-caboose.postgres.service.sslMode"
    value = var.custom_postgres_settings["postgres"]["service"]["sslMode"]
  }

  set {
    name  = "swoop-caboose.postgres.service.authMethod"
    value = var.custom_postgres_settings["postgres"]["service"]["authMethod"]
  }

  set {
    name  = "swoop-caboose.postgres.service.schemaVersionTable"
    value = var.custom_postgres_settings["postgres"]["deployment"]["schemaVersionTable"]
  }

  set {
    name  = "swoop-caboose.postgres.migration.enabled"
    value = var.deploy_db_migration
  }

  set {
    name  = "swoop-caboose.postgres.migration.imagePullPolicy"
    value = var.custom_input_map["dbMigration.imagePullPolicy"]
  }

  set {
    name  = "swoop-caboose.postgres.migration.jobName"
    value = var.custom_input_map["dbMigration.jobName"]
  }

  set {
    name  = "swoop-caboose.postgres.migration.version"
    value = var.custom_input_map["dbMigration.version"]
  }

  set {
    name  = "swoop-caboose.minio.service.name"
    value = var.custom_minio_settings["minio"]["service"]["name"]
  }

  set {
    name  = "swoop-caboose.minio.service.bucketName"
    value = var.custom_minio_settings["minio"]["service"]["bucketName"]
  }

  set {
    name  = "swoop-caboose.minio.service.accessKeyId"
    value = var.custom_minio_settings["minio"]["service"]["accessKeyId"]
  }

  set {
    name  = "swoop-caboose.minio.service.secretAccessKey"
    value = var.custom_minio_settings["minio"]["service"]["secretAccessKey"]
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.accessKeySecret.name"
    value = "swoop-minio-secret"
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.accessKeySecret.key"
    value = "accesskey"
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.secretKeySecret.name"
    value = "swoop-minio-secret"
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.secretKeySecret.key"
    value = "secretkey"
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.insecure"
    value = true
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.bucket"
    value = var.custom_minio_settings["minio"]["service"]["bucketName"]
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.endpoint"
    value = "${var.custom_minio_settings["minio"]["service"]["name"]}.${var.minio_namespace}:${var.custom_minio_settings["minio"]["service"]["port"]}"
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.useSDKCreds"
    value = false
  }

  set {
    name  = "swoop-caboose.argo-workflows.artifactRepository.s3.encryptionOptions.enableEncryption"
    value = false
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.host"
    value = "${var.custom_postgres_settings["postgres"]["service"]["name"]}.${var.postgres_namespace}"
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.port"
    value = var.custom_postgres_settings["postgres"]["service"]["port"]
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.database"
    value = var.custom_postgres_settings["postgres"]["service"]["dbName"]
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.tableName"
    value = "argo_workflows"
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.userNameSecret.name"
    value = "swoop-postgres-secret"
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.userNameSecret.key"
    value = "username"
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.passwordSecret.name"
    value = "swoop-postgres-secret"
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.persistence.postgresql.passwordSecret.key"
    value = "password"
  }

  set {
    name  = "swoop-caboose.argo-workflows.controller.workflowNamespaces[0]"
    value = var.namespace
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

  depends_on = [
    kubernetes_secret.swoop_postgres_secret,
    kubernetes_secret.swoop_minio_secret
  ]
}

resource "kubernetes_secret" "swoop_postgres_secret" {
  metadata {
    name = "swoop-postgres-secret"
    namespace = var.namespace
  }

  data = {
    username = base64decode(var.custom_postgres_settings["postgres"]["service"]["dbUser"])
    password = base64decode(var.custom_postgres_settings["postgres"]["service"]["dbPassword"])
  }
}

resource "kubernetes_secret" "swoop_minio_secret" {
  metadata {
    name = "swoop-minio-secret"
    namespace = var.namespace
  }

  data = {
    accesskey = base64decode(var.custom_minio_settings["minio"]["service"]["accessKeyId"])
    secretkey = base64decode(var.custom_minio_settings["minio"]["service"]["secretAccessKey"])
  }
}
