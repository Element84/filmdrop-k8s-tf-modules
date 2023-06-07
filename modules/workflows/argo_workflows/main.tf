resource "kubernetes_namespace" "argo_workflows" {
  metadata {

    labels = {
      app = var.namespace
    }

    name = var.namespace
  }
}

resource "kubernetes_secret" "argo_postgres_config" {
  metadata {
    name = "argo-postgres-config"
    namespace = var.namespace
  }

  data = {
    username = base64decode(var.custom_postgres_settings["postgres"]["service"]["dbUser"])
    password = base64decode(var.custom_postgres_settings["postgres"]["service"]["dbPassword"])
  }

  depends_on = [
    kubernetes_namespace.argo_workflows
  ]

}

resource "kubernetes_secret" "my_minio_cred" {
  metadata {
    name = "my-minio-cred"
    namespace = var.namespace
  }

  data = {
    accesskey = base64decode(var.custom_minio_settings["minio"]["service"]["accessKeyId"])
    secretkey = base64decode(var.custom_minio_settings["minio"]["service"]["secretAccessKey"])
  }

  depends_on = [
    kubernetes_namespace.argo_workflows
  ]

}

resource "helm_release" "argo_workflows" {
  name              = "argo-workflows"
  namespace         = var.namespace
  chart             = "argo-workflows"
  repository        = "https://argoproj.github.io/argo-helm"
  atomic            = true

  set {
    name  = "artifactRepository.s3.accessKeySecret.name"
    value = "my-minio-cred"
  }

  set {
    name  = "artifactRepository.s3.accessKeySecret.key"
    value = "accesskey"
  }

  set {
    name  = "artifactRepository.s3.secretKeySecret.name"
    value = "my-minio-cred"
  }

  set {
    name  = "artifactRepository.s3.secretKeySecret.key"
    value = "secretkey"
  }

  set {
    name  = "artifactRepository.s3.insecure"
    value = true
  }

  set {
    name  = "artifactRepository.s3.bucket"
    value = var.custom_minio_settings["minio"]["service"]["bucketName"]
  }

  set {
    name  = "artifactRepository.s3.endpoint"
    value = "${var.custom_minio_settings["minio"]["service"]["name"]}.${var.minio_namespace}:${var.custom_minio_settings["minio"]["service"]["port"]}"
  }

  set {
    name  = "artifactRepository.s3.useSDKCreds"
    value = false
  }

  set {
    name  = "artifactRepository.s3.encryptionOptions.enableEncryption"
    value = false
  }

  set {
    name  = "minio.service.bucketName"
    value = var.custom_minio_settings["minio"]["service"]["bucketName"]
  }

  set {
    name  = "minio.service.accessKeyId"
    value = var.custom_minio_settings["minio"]["service"]["accessKeyId"]
  }

  set {
    name  = "minio.service.secretAccessKey"
    value = var.custom_minio_settings["minio"]["service"]["secretAccessKey"]
  }

  set {
    name  = "controller.persistence.postgresql.host"
    value = "${var.custom_postgres_settings["postgres"]["service"]["name"]}.${var.postgres_namespace}"
  }

  set {
    name  = "controller.persistence.postgresql.port"
    value = var.custom_postgres_settings["postgres"]["service"]["port"]
  }

  set {
    name  = "controller.persistence.postgresql.database"
    value = var.custom_postgres_settings["postgres"]["service"]["dbName"]
  }

  set {
    name  = "controller.persistence.postgresql.tableName"
    value = "argo_workflows"
  }

  set {
    name  = "controller.persistence.postgresql.userNameSecret.name"
    value = "argo-postgres-config"
  }

  set {
    name  = "controller.persistence.postgresql.userNameSecret.key"
    value = "username"
  }

  set {
    name  = "controller.persistence.postgresql.passwordSecret.name"
    value = "argo-postgres-config"
  }

  set {
    name  = "controller.persistence.postgresql.passwordSecret.key"
    value = "password"
  }

  values = [
    file("${path.module}/charts/argo-workflows/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.argo_workflows,
    kubernetes_secret.argo_postgres_config,
    kubernetes_secret.my_minio_cred
  ]
}
