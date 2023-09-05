module "workflow_config" {
  source                = "./workflow_config"
  count                 = var.deploy_workflow_config == true ? 1 : 0

  namespace                                             = var.namespace
  aws_access_key                                        = var.aws_access_key
  aws_secret_access_key                                 = var.aws_secret_access_key
  aws_region                                            = var.aws_region
  aws_session_token                                     = var.aws_session_token
  namespace_annotations                                 = var.namespace_annotations
  s3_secret                                             = var.s3_secret
  create_s3_secret                                      = var.create_s3_secret
  custom_swoop_workflow_config_map                      = var.custom_swoop_workflow_config_map
  swoop_workflow_config_additional_configuration_values = var.swoop_workflow_config_additional_configuration_values
  custom_swoop_workflow_config_values_yaml              = var.custom_swoop_workflow_config_values_yaml
  custom_minio_input_map                                = var.custom_minio_input_map
  minio_secret                                          = var.minio_secret
  minio_namespace                                       = var.minio_namespace
  workflow_config_version                               = var.workflow_config_version
  swoop_workflow_output_s3_bucket                       = var.swoop_workflow_output_s3_bucket
  swoop_sa_iam_role                                     = var.swoop_sa_iam_role
}

module "copy_s3_secret_to_workflow_config_namespace" {
  source  = "./s3_secrets"
  count   = var.deploy_workflow_config == true && var.create_s3_secret == false && var.swoop_sa_iam_role == "" && var.namespace != var.s3_secret_namespace ? 1 : 0

  namespace               = var.namespace
  s3_secret_namespace     = var.s3_secret_namespace
  s3_secret               = var.s3_secret
}
