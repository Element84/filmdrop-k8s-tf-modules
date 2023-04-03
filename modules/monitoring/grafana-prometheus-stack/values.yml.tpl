prometheusOperator:
  admissionWebhooks:
    patch:
      podAnnotations:
        linkerd.io/inject: disabled
  podAnnotations:
    linkerd.io/inject: enabled

grafana:
  podAnnotations:
    linkerd.io/inject: enabled
  service:
    port: 3009
  additionalDataSources:
%{ for grafana_data_source in grafana_additional_data_sources ~}
    - name: ${grafana_data_source.name}
      type: ${grafana_data_source.type}
      isDefault: ${grafana_data_source.isDefault}
      access: ${grafana_data_source.access}
      url: ${grafana_data_source.url}
      version: ${grafana_data_source.version}
%{ endfor ~}

kube-state-metrics:
  podAnnotations:
    linkerd.io/inject: enabled
