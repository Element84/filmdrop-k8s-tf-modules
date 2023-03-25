provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
  shared_credentials_files = ["~/.aws/credentials"]
}