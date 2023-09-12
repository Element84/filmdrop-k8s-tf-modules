terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    http = {
      source = "hashicorp/http"
      version = "3.4.0"
    }
  }
}
