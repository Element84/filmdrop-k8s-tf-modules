## Deploying an EKS cluster

To deploy an EKS cluster with Linkerd, the Ingress Nginx controller, and Argo Workflows, we first need to create an EKS cluster. Then, we can install the necessary components onto the cluster.

Before getting started, check all folders to ensure that there are no Terraform state or lock files/folders in any folder. If there are, then delete them. 

To create an EKS cluster using the provided Terraform module:

1) Create a named profile within your AWS credentials file (located at ```~/.aws/credentials```) named ```manta``` that has the credentials to authenticate to the Manta AWS DEV-Filmdrop account. 
2) ```cd``` into the ```eks/cluster-setup/cluster``` directory. Provide the appropriate configuration variables for the cluster by supplying values to the ```eks.tfvars``` file in this folder. The most important values here that need to be supplied are the VPC ID of an existing VPC (```vpc_id(```), subnet IDs for two existing public subnets within the VPC (```subnet_ids```) that are in two different availability zones, and the name of the cluster that you want to create (```cluster_name```). The subnets have to be in two different availability zones in the AWS region specified by the ```aws_region``` variable; for example, one subnet in ```us-west-2a``` and another subnet in ```us-west-2b```. All other values can be kept as-is. Make sure that the ```cluster_version``` is at least 1.24, which makes ```containerd``` get used as the default container runtime for the EKS instance AMI's that will get created. This fixes some permission problems within the EKS cluster during deployment that would arise if Docker was used as the container runtime (default for EKS AMI's prior to v. 1.24). 
3) Run ```terraform init```. This will install the necessary plugins for the AWS provider in this folder. 
4) Run ```terraform apply --var-file=eks.tfvars --auto-approve``` to deploy the EKS cluster. IMPORTANT: This process will take approximately 10-15 minutes. 

After cluster creation, you will see an output value in the terminal window for the ```eks_cluster_arn```. You will need this value in step 6. 

The above steps will create an EKS cluster with an EKS Managed Node Group (see [Managed Node Groups](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html)). By default, this creates the worker node EC2 instances inside of an Auto Scaling Group that is managed by EKS. The required IAM roles/policies for the EKS cluster are also created.

To deploy the remaining components onto the cluster: 

5) ```cd``` up a level into the ```cluster-setup``` directory. Run ```terraform init```. 
6) Provide the EKS cluster ARN from step 4 into the ```kubernetes_config_context``` variable in the ```config.tfvars``` file in this directory. For example, if the cluster ARN is ```arn:aws:eks:us-west-2:806042826993:cluster/ekscluster3-cluster```, the ```config.tfvars``` file would contain ```kubernetes_config_context=arn:aws:eks:us-west-2:806042826993:cluster/ekscluster3-cluster```. Also, make sure that the ```inputs.tf``` file in the root directory (i.e. ```FilmDrop K8S TF Modules```) has these defaults set for variables:

* ```local_or_eks```: ```eks``` 
* ```kubernetes_config_context``` : ```arn:aws:eks:us-west-2:806042826993:cluster/ekscluster3-cluster```

7) Run ```terraform apply --var-file=config.tfvars --auto-approve```. This process will take approximately 3-5 minutes. 

You can verify if everything has been deployed by running ```kubectl get namespace``` in a terminal window, which should then show the ```argo-workflows```, ```hello-world```, ```monitoring```, ```argo-other```, and ```linkerd```namespaces in addition to any other namespaces that were defined in the root module.



### Viewing the Linkerd Dashboard

After the cluster and all components are deployed, in order to view the Linkerd Dashboard:

1) Install the Linkerd CLI onto your local machine using ```curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh```

2) Run a ```linkerd check``` to ensure that everything is running correctly. If the check for ```cluster networks contains all pods``` fails, it will tell you which of the pods are not getting discovered by the service mesh along with their IP addresses. In order to view the Dashboard, you need to update the default value for the ```control_plane_clusternetworks``` variable in the ```eks/variables.tf`` file to include the IP address of these pods. For example, if one of the pods at IP address 13.0.1.236 is unreachable, you need to append this to the variable's default value like this:

```default     = "10.0.0.0/8,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16,13.0.1.236/24"```

Then, run ```terraform apply --var-file=config.tfvars --auto-approve``` again to update the Linkerd control plane with this setting. 

3) Run a ```linkerd check``` again to ensure that the check for ```cluster networks contains all pods``` succeeds.

4) Install the ```linkerd-viz``` extension by running ```linkerd viz install | kubectl apply -f -```.

5) Run ```linkerd viz dashboard &```. This will automatically open up the Linkerd Dashboard on a new tab in your browser at a localhost port. This process can take up to 30 seconds.
