
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
  "tcp.8000"                                      = "swoop/swoop-api:8000"
  "tcp.9000"                                      = "io/minio:9000"
  "tcp.9001"                                      = "io/minio:9001"
  "tcp.5432"                                      = "db/postgres:5432"
  "tcp.9090"                                      = "monitoring/kube-prometheus-stack-prometheus:9090"
  "tcp.3009"                                      = "monitoring/kube-prometheus-stack-grafana:3009"
  "tcp.8080"                                      = "stac/stac-fastapi-pgstac:8080"
}

#### Component flags: Deploy everything with the exception of Linkerd, TiTiler, stac-fastapi, and Argo Events
deploy_linkerd            = false
deploy_ingress_nginx      = true
deploy_grafana_prometheus = true
deploy_loki               = true
deploy_promtail           = true
deploy_argo_workflows     = true
deploy_titiler            = false
deploy_stacfastapi        = false
deploy_swoop_api          = true
deploy_swoop_caboose      = true
deploy_db_migration       = true
deploy_postgres           = true
deploy_db_init            = true
deploy_minio              = true
deploy_workflow_config    = false
