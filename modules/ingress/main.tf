module "ingress_nginx" {
  count = var.deploy_ingress_nginx == true ? 1 : 0
  source = "./nginx"

  kubernetes_config_file    = var.kubernetes_config_file
  kubernetes_config_context = var.kubernetes_config_context
  nginx_http_port           = var.nginx_http_port
  nginx_https_port          = var.nginx_https_port
  extra_values              = var.nginx_extra_values
}
