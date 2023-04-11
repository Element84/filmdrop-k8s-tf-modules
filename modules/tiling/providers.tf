terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

# provider "kubernetes" {
#   config_path = pathexpand("~/.kube/config")
#   config_context = "rancher-desktop"
# }

# provider "helm" {
#   kubernetes {
#     config_path = pathexpand("~/.kube/config")
#     config_context = "rancher-desktop"
#   }
# }
