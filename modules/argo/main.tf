module "argo_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_argo_workflows == true ? var.create_namespace : false
  namespace             = var.namespace
}

module "argo_workflows" {
  count   = var.deploy_argo_workflows == true ? 1 : 0
  source  = "./argo_workflows"

  custom_minio_settings     = var.custom_minio_settings
  custom_postgres_settings  = var.custom_postgres_settings
  minio_namespace           = var.minio_namespace
  postgres_namespace        = var.postgres_namespace
  namespace                 = var.namespace

  depends_on = [
    module.argo_namespace
  ]
}

module "argo_events" {
  count   = var.deploy_argo_events == true ? 1 : 0
  source  = "./argo_events"

  kubernetes_config_file      = var.kubernetes_config_file
  kubernetes_config_context   = var.kubernetes_config_context

  depends_on = [
    module.argo_workflows[0]
  ]
}
