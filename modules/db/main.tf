module "db_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_postgres == true || var.deploy_db_init == true ? var.create_namespace : false
  namespace             = var.namespace
}


module "postgres" {
  source = "./postgres"
  count  = var.deploy_postgres == true ? 1 : 0

  namespace                                = var.namespace
  postgres_version                         = var.postgres_version
  postgres_additional_configuration_values = var.postgres_additional_configuration_values
  custom_postgres_values_yaml              = var.custom_postgres_values_yaml
  custom_input_map                         = var.custom_input_map

  depends_on = [module.db_namespace]
}

module "db_init" {
  source = "./db-init"
  count  = var.deploy_db_init == true ? 1 : 0

  namespace                                = var.namespace
  db_init_version                          = var.db_init_version
  postgres_additional_configuration_values = var.postgres_additional_configuration_values
  custom_postgres_values_yaml              = var.custom_postgres_values_yaml
  custom_input_map                         = var.custom_input_map

  depends_on = [
    module.db_namespace,
    module.postgres,
  ]
}
