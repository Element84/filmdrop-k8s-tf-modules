
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

nginx_extra_values = {}

#### Component flags: Deploy only Ingress NGINX with SWOOP API, Postgres and MinIO for GitHub Actions and other minimal testing
deploy_linkerd            = false
deploy_ingress_nginx      = false
deploy_grafana_prometheus = false
deploy_loki               = false
deploy_promtail           = false
deploy_argo_workflows     = false
deploy_titiler            = false
deploy_stacfastapi        = false
deploy_swoop_api          = true
deploy_swoop_caboose      = false
deploy_db_migration       = true
deploy_postgres           = true
deploy_db_init            = true
deploy_minio              = true
