# ------------------------------------------------------------
# Networking Settings
# ------------------------------------------------------------
aws_profile = "manta"
aws_region = "us-west-2"
vpc_id = "vpc-08a632e71695b023c"
subnet_ids = ["subnet-09f3943e1430bac14","subnet-05dd19ab08f935564"]
# ------------------------------------------------------------
# EKS Cluster Settings
# ------------------------------------------------------------
cluster_name = "eks"
cluster_version = "1.25"
node_group_instance_type = ["t3.large"]
autoscaling_group_min_size = 1
autoscaling_group_max_size = 3
autoscaling_group_desired_capacity = 1