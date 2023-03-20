
high_availability = false
cert_validity_period_hours = 8760 # 1 year
linkerd_additional_configuration_values = []
ingress_controller = "nginx"

### Point to your local kubernetes configuration file and context
kubernetes_config_file = "~/.kube/config"
kubernetes_config_context = "rancher-desktop"