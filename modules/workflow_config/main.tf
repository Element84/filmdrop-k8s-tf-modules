module "workflow_config" {
  count     = var.deploy_workflow_config == true ? 1 : 0
  source    = "./workflow_config"
  namespace = var.namespace

  namespace_annotations = var.namespace_annotations

}
