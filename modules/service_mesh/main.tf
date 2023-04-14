module "linkerd" {
  count   = var.deploy_linkerd == true ? 1 : 0
  source  = "./linkerd"

  high_availability                         = var.high_availability
  cert_validity_period_hours                = var.cert_validity_period_hours
  linkerd_additional_configuration_values   = var.linkerd_additional_configuration_values
}
