module "services" {
  source = "../../"
  kubernetes_config_context = var.kubernetes_config_context
  linkerd_additional_configuration_values = ["clusterNetworks: 10.0.0.0/8,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16"]
}