module "workflow_config" {
  count                 = var.deploy_workflow_config == true ? 1 : 0
  source                = "./workflow_config"
  namespace             = var.namespace
  aws_access_key        = var.aws_access_key
  aws_secret_access_key = var.aws_secret_access_key
  aws_region            = var.aws_region
  aws_session_token     = var.aws_session_token
  namespace_annotations = var.namespace_annotations
  s3_secret             = var.s3_secret
  create_s3_secret      = var.create_s3_secret

}
