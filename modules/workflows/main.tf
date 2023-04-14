module "argo_workflows" {
  count   = var.deploy_argo_workflows == true ? 1 : 0
  source  = "./argo_workflows"

  namespace_annotations = var.namespace_annotations
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
