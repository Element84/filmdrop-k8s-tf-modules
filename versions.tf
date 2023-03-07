terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.18.1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
  required_version = ">= 1"
}
