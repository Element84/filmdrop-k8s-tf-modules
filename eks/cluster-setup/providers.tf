provider "kubernetes" {
  config_path     = pathexpand(var.kubernetes_config_file)
  config_context  = var.kubernetes_config_context
}

provider "helm" {
  kubernetes {
    config_path     = pathexpand(var.kubernetes_config_file)
    config_context  = var.kubernetes_config_context
  }
}