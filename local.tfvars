
high_availability = false
cert_validity_period_hours = 8760 # 1 year
linkerd_additional_configuration_values = []

### Point to your local kubernetes configuration file and context
kubernetes_config_file = "~/.kube/config"
kubernetes_config_context = "rancher-desktop"

#### Monitoring stack configuration
loki_extra_values = {
  "write.podAnnotations.linkerd\\.io/inject" = "enabled"
  "backend.podAnnotations.linkerd\\.io/inject" = "enabled"
  "read.podAnnotations.linkerd\\.io/inject" = "enabled"
}

promtail_extra_values = {
  "podAnnotations.linkerd\\.io/inject" = "enabled"
}

grafana_additional_data_sources = [{
  name        = "Loki"
  type        = "loki"
  isDefault   = "no"
  access      = "proxy"
  url         = "http://loki-read:3100"
  version     = 1
}]

grafana_prometheus_extra_values = {
  "prometheusOperator.admissionWebhooks.patch.podAnnotations.linkerd\\.io/inject" = "disabled"
  "prometheusOperator.podAnnotations.linkerd\\.io/inject" = "enabled"
  "grafana.podAnnotations.linkerd\\.io/inject" = "enabled"
  "kube-state-metrics.podAnnotations.linkerd\\.io/inject" = "enabled"
}

namespace_annotations = {
  "linkerd.io/inject" = "enabled"
}

nginx_extra_values = {
  "controller.podAnnotations.linkerd\\.io/inject" = "enabled"
  "controller.ingressClassResource.default"       = "true"
}

#### Component flags: Deploy everything with the exception of Nginx, Hello World App and Argo Events
deploy_linkerd            = true
deploy_ingress_nginx      = false
deploy_hello_world        = false
deploy_grafana_prometheus = true
deploy_loki               = true
deploy_promtail           = true
deploy_argo_workflows     = true
deploy_argo_events        = false
