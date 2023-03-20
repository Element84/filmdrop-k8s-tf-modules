module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "2.3.0"

  region     = var.aws_region
  subnet_ids = var.subnet_ids
  vpc_id     = var.vpc_id
  name       = var.cluster_name
  kubernetes_version = var.cluster_version

}

module "eks_node_group" {
  source  = "cloudposse/eks-node-group/aws"
  version = "2.4.0"
  cluster_name   = module.eks_cluster.eks_cluster_id
  instance_types = var.node_group_instance_type
  subnet_ids     = var.subnet_ids
  min_size       = var.autoscaling_group_min_size
  desired_size   = var.autoscaling_group_desired_capacity
  max_size       = var.autoscaling_group_max_size
  depends_on     = [null_resource.merge_kubeconfig, module.eks_cluster.kubernetes_config_map_id]
}


resource "null_resource" "merge_kubeconfig" {
  triggers = {
    always = timestamp()
  }

  depends_on = [module.eks_cluster]

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = <<EOT
      set -e
      echo 'Applying Auth ConfigMap with kubectl...'
      aws eks wait cluster-active --name '${var.cluster_name}-cluster' --profile '${var.aws_profile}' --region=${var.aws_region}
      aws eks update-kubeconfig --name '${var.cluster_name}-cluster' --profile '${var.aws_profile}' --region=${var.aws_region}
      kubectl config use-context ${local.context}
    EOT
  }
}

locals {
  context = module.eks_cluster.eks_cluster_arn 
}

