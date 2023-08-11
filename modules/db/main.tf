module "db_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_postgres == true || var.deploy_db_init == true ? var.create_namespace : false
  namespace             = var.namespace
}

module "db_secrets" {
  source  = "./secrets"
  count   = var.deploy_postgres == true || var.deploy_db_init == true ? 1 : 0

  namespace           = var.namespace
  dbadmin_username    = var.dbadmin_username
  dbadmin_password    = var.dbadmin_password
  dbadmin_secret      = var.dbadmin_secret
  owner_username      = var.owner_username
  owner_password      = var.owner_password
  owner_secret        = var.owner_secret
  api_username        = var.api_username
  api_password        = var.api_password
  api_secret          = var.api_secret
  caboose_username    = var.caboose_username
  caboose_password    = var.caboose_password
  caboose_secret      = var.caboose_secret
  conductor_username  = var.conductor_username
  conductor_password  = var.conductor_password
  conductor_secret    = var.conductor_secret

  depends_on = [
    module.db_namespace,
  ]
}

module "postgres" {
  source = "./postgres"
  count  = var.deploy_postgres == true ? 1 : 0

  namespace                                = var.namespace
  postgres_version                         = var.postgres_version
  postgres_additional_configuration_values = var.postgres_additional_configuration_values
  custom_postgres_values_yaml              = var.custom_postgres_values_yaml
  custom_postgres_input_map                = var.custom_postgres_input_map
  dbadmin_secret                           = var.dbadmin_secret
  deploy_db_migration                      = var.deploy_db_migration

  depends_on = [
    module.db_namespace,
    module.db_secrets,
  ]
}

module "db_init" {
  source = "./db-init"
  count  = var.deploy_db_init == true ? 1 : 0

  namespace                                = var.namespace
  db_init_version                          = var.db_init_version
  postgres_additional_configuration_values = var.postgres_additional_configuration_values
  custom_postgres_values_yaml              = var.custom_postgres_values_yaml
  custom_postgres_input_map                = var.custom_postgres_input_map
  dbadmin_secret                           = var.dbadmin_secret
  owner_secret                             = var.owner_secret
  api_secret                               = var.api_secret
  caboose_secret                           = var.caboose_secret
  conductor_secret                         = var.conductor_secret
  deploy_db_migration                      = var.deploy_db_migration

  depends_on = [
    module.db_namespace,
    module.postgres,
    module.db_secrets,
  ]
}
