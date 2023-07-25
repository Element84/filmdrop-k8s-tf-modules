module "ingress_namespace" {
  source = "../namespace"

  namespace_annotations = var.namespace_annotations
  create_namespace      = var.deploy_ingress_nginx == true ? var.create_namespace : false
  namespace             = var.namespace
}

module "ingress_nginx" {
  count = var.deploy_ingress_nginx == true ? 1 : 0
  source = "./nginx"

  kubernetes_config_file                        = var.kubernetes_config_file
  kubernetes_config_context                     = var.kubernetes_config_context
  extra_values                                  = var.nginx_extra_values
  namespace                                     = var.namespace
  ingress_nginx_version                         = var.ingress_nginx_version
  custom_ingress_nginx_values_yaml              = var.custom_ingress_nginx_values_yaml
  ingress_nginx_additional_configuration_values = var.ingress_nginx_additional_configuration_values

  depends_on = [ module.ingress_namespace ]
}
