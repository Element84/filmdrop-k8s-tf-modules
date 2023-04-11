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

# Uncomment this portion if installing from the module directory

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