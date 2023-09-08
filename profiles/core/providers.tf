terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    tls = {
      source = "hashicorp/tls"
    }
    null = {
      source  = "hashicorp/null"
    }
    grafana = {
      source  = "grafana/grafana"
    }
    http = {
      source = "hashicorp/http"
      version = "3.4.0"
    }
  }
}
