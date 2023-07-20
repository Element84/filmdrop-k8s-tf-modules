
high_availability = false
cert_validity_period_hours = 8760 # 1 year
linkerd_additional_configuration_values = []

### Point to your local kubernetes configuration file and context
kubernetes_config_file = "~/.kube/config"
kubernetes_config_context = "rancher-desktop"

loki_extra_values = {}

promtail_extra_values = {}

grafana_additional_data_sources = []

grafana_prometheus_extra_values = {}

namespace_annotations = {}

nginx_extra_values = {
  "controller.ingressClassResource.default"       = "true"
  "tcp.8000"                                      = "swoop/swoop-api:8000"
  "tcp.9000"                                      = "io/minio:9000"
  "tcp.9001"                                      = "io/minio:9001"
  "tcp.5432"                                      = "db/postgres:5432"
}

#### Component flags: Deploy only Ingress NGINX with SWOOP API, Postgres and MinIO for GitHub Actions and other minimal testing
deploy_linkerd            = false
deploy_ingress_nginx      = true
deploy_grafana_prometheus = false
deploy_loki               = false
deploy_promtail           = false
deploy_argo_workflows     = false
deploy_argo_events        = false
deploy_titiler            = false
deploy_stacfastapi        = false
deploy_swoop_api          = true
deploy_postgres           = true
deploy_minio              = true
