resource "helm_release" "workflow_config" {
  name              = "workflow-config"
  namespace         = var.namespace
  repository        = "https://element84.github.io/filmdrop-k8s-helm-charts"
  chart             = "workflow-config"
  version           = var.workflow_config_version
  atomic            = true
  create_namespace  = false
  wait              = true

  set {
    name  = "s3.createSecret"
    value = var.create_s3_secret
  }

  set {
    name  = "s3.accessKeyIdSecret.name"
    value = var.s3_secret
  }

  set {
    name  = "s3.secretAccessKeySecret.name"
    value = var.s3_secret
  }

  set {
    name  = "s3.regionSecret.name"
    value = var.s3_secret
  }

  set {
    name  = "s3.sessionTokenSecret.name"
    value = var.s3_secret
  }

  set {
    name  = "s3.accessKeyId"
    value = var.aws_access_key
  }

  set {
    name  = "s3.secretAccessKey"
    value = var.aws_secret_access_key
  }

  set {
    name  = "s3.region"
    value = var.aws_region
  }

  set {
    name  = "s3.sessionToken"
    value = var.aws_session_token
  }

  dynamic "set" {
    for_each = var.custom_minio_input_map

    content {
      name  = "minio.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "minio.service.endpoint"
    value = "${var.custom_minio_input_map["service.name"]}.${var.minio_namespace}:${var.custom_minio_input_map["service.port"]}" 
  }

  set {
    name  = "minio.service.accessKeyIdSecret.name"
    value = "${var.namespace}-${var.minio_secret}"
  }

  set {
    name  = "minio.service.secretAccessKeySecret.name"
    value = "${var.namespace}-${var.minio_secret}"
  }


  dynamic "set" {
    for_each = var.custom_swoop_workflow_config_map

    content {
      name  = set.key
      value = set.value
    }
  }

  values = concat(
    [var.custom_swoop_workflow_config_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_swoop_workflow_config_values_yaml)],
    length(var.swoop_workflow_config_additional_configuration_values) == 0 ? [] : var.swoop_workflow_config_additional_configuration_values
  )
}
