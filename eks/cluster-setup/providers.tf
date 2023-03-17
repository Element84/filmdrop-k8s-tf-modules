provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
  shared_credentials_files = ["~/.aws/credentials"]
}


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