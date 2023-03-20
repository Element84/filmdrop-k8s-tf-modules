output "eks_cluster_arn" {
    value = module.eks_cluster.eks_cluster_arn
    description = "ARN of the EKS cluster that was created"
}