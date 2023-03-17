## Deploying an EKS cluster

To deploy an EKS cluster with Linkerd, the Ingress Nginx controller, and Argo Workflows, we first need to create an EKS cluster. Then, we can install the necessary components onto the cluster.

Before getting started, check all folders to ensure that there are no Terraform state or lock files/folders in any folder. If there are, then delete them. 

To create an EKS cluster using the provided Terraform module:

1) Create a named profile within your AWS credentials file (located at ```./~/.aws/credentials```) named ```manta``` that has the credentials to authenticate to the Manta AWS account. 
2) ```cd``` into the ```eks/cluster-setup/cluster``` directory. Provide the appropriate configuration variables for the cluster by supplying values to the ```eks.tfvars``` file in this folder. The most important values here that need to be supplied are the VPC ID of an existing VPC (```vpc_id(```), subnet IDs for two existing public subnets within the VPC (```subnet_ids```), and the name of the cluster that you want to create (```cluster_name```). All other values can be kept as-is. Make sure that the ```cluster_version``` is at least 1.24 in order for ```containerd``` to be the default container runtime for the EKS instance AMI's that will get created. This fixes some permission problems within the EKS cluster during deployment that would arise if Docker was used as the container runtime (default for EKS AMI's prior to v. 1.24). 
3) Run ```terraform init```. This will install the necessary plugins for the AWS provider in this folder. 
4) Run ```terraform apply --var-file=eks.tfvars --auto-approve``` to deploy the EKS cluster. IMPORTANT: This process will take approximately 10-15 minutes. 

After cluster creation, you will see an output value in the terminal window for the ```eks_cluster_arn```. You will need this value in step 6. 

The above steps will create an EKS cluster with an EKS Managed Node Group (see [Managed Node Groups](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html) named ```workers```. By default, this creates EC2 instances inside of an Auto Scaling Group that is managed by EKS. The required IAM roles/policies for the EKS cluster are also created.

To deploy the remaining components onto the cluster: 

5) ```cd``` into the ```cluster-setup``` directory. Run ```terraform init```. 
6) Provide the EKS cluster ARN from step 4 into the ```kubernetes_config_context``` variable in the ```config.tfvars``` file in this directory. For example, if the cluster ARN is ```arn:aws:eks:us-west-2:806042826993:cluster/ekscluster3-cluster```, the ```config.tfvars``` file would contain ```kubernetes_config_context=arn:aws:eks:us-west-2:806042826993:cluster/ekscluster3-cluster```. Also, make sure that the ```inputs.tf``` file in the root directory (i.e. ```FilmDrop K8S TF Modules```) has these defaults set for variables:
* ```local_or_eks```: ```eks``` 
* ```kubernetes_config_context``` : ```arn:aws:eks:us-west-2:806042826993:cluster/ekscluster3-cluster```

7) Run ```terraform apply --var-file=config.tfvars```. This process will take approximately 3-5 minutes. 