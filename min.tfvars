
high_availability = false
cert_validity_period_hours = 8760 # 1 year
linkerd_additional_configuration_values = []

loki_extra_values = {}

promtail_extra_values = {}

grafana_additional_data_sources = []

grafana_prometheus_extra_values = {}

namespace_annotations = {}

nginx_extra_values = {}

#### Component flags: Deploy only SWOOP API, Postgres and MinIO for GitHub Actions and other minimal testing
deploy_linkerd            = false
deploy_ingress_nginx      = false
deploy_hello_world        = false
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
