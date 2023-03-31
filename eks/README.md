## Deploying an EKS cluster

There are two steps in deploying an EKS cluster with all K8s services. The first step is deploying a base EKS cluster. The second step is deploying services on top of the cluster.

Before getting started, check all folders to ensure that there are no Terraform state or lock files/folders in any folder. If there are, then delete them.

Also, make sure that your kubeconfig file does not contain any existing AWS EKS contexts/clusters/users. If there are any, then delete them using ```kubectl config delete-``` commands.

To create an EKS cluster using the provided Terraform modules:

1) Create a named profile within your AWS credentials file (located at ```~/.aws/credentials```) named ```project-name``` that has the credentials to authenticate to the AWS account.
2) Comment out the entire ```providers.tf``` file in the root (i.e. ```FilmDrop K8S TF Modules```) directory.
3) ```cd``` into the ```eks/cluster-setup/base-cluster``` directory. Provide the appropriate configuration variables for the cluster by supplying values to the ```eks.tfvars``` file in this folder. The most important values here that need to be supplied are the subnet IDs for two existing subnets (```subnet_ids```) that are in two different availability zones within a VPC that already exists, and the name of the cluster that you want to create (```cluster_name```). The subnets have to be in two different availability zones in the AWS region specified by the ```aws_region``` variable; for example, one subnet in ```us-west-2a``` and another subnet in ```us-west-2b```. All other values can be kept as-is. Make sure that the ```cluster_version``` is at least 1.24, which makes ```containerd``` get used as the default container runtime for the EKS instance AMI's that will get created. This fixes some permission problems within the EKS cluster during deployment that would arise if Docker was used as the container runtime (default for EKS AMI's prior to v. 1.24).
4) Run ```terraform init```. This will install the necessary plugins for the AWS provider in this folder.
5) Run ```terraform apply --var-file=eks.tfvars``` to deploy the base EKS cluster. This process will take approximately 10-15 minutes.

6) After the process finishes, you will see the EKS cluster ARN as an output variable in the Terminal window. You will need this in the next step.

The above steps will create an EKS cluster with an EKS Managed Node Group (see [Managed Node Groups](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html)). By default, this creates the worker node EC2 instances inside of an Auto Scaling Group that is managed by EKS. The required IAM roles/policies for the EKS cluster are also created. You can view the cluster that was created in the AWS EKS console. The process will also automatically switch your ```kubectl``` context to that of the EKS cluster that was created.

7) ```cd``` one level up into the ```eks/cluster-setup``` directory. Run ```terraform init```, followed by ```terraform apply -var="kubernetes_config_context=<CLUSTER_ARN>"```. Replace ```<CLUSTER_ARN>``` with the ARN you received in step 6. This process will take an additional 3-5 minutes.

You can verify if everything has been deployed by running ```kubectl get namespace``` in a terminal window, which should then show the ```argo-workflows```, ```hello-world```, ```monitoring```, ```argo-other```, and ```linkerd```namespaces in addition to any other namespaces that were defined in the root module.


## Destroying the EKS cluster

To destroy only the services running on top of the EKS cluster, from within the ```eks/cluster-setup``` directory, run ```terraform destroy -var="kubernetes_config_context=<CLUSTER_ARN>```. This process can take up to 5 minutes.

To destroy only the base EKS cluster itself, run ```terraform destroy``` from within the ```eks/cluster-setup/base-cluster``` directory. This process can take up to 10 minutes.

Also, make sure to do:

```kubectl config delete-cluster <cluster_arn>```  <br />
```kubectl config delete-context <cluster_arn>```  <br />
```kubectl config delete-user <cluster_arn>```  <br />

to update your kubeconfig file after the cluster has been destroyed.

### Viewing the Linkerd Dashboard

After the cluster and all components are deployed, in order to view the Linkerd Dashboard:

1) Install the Linkerd CLI onto your local machine using ```curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh```

2) Run a ```linkerd check``` to ensure that everything is running correctly. If the check for ```cluster networks contains all pods``` fails, it will tell you which of the pods are not getting discovered by the service mesh along with their IP addresses. In order to view the Dashboard, you need to update the default value for the ```clusterNetworks``` variable in the ```eks/cluster-setup/services.tf``` file to include the IP address of these pods. For example, if one of the pods at IP address ```13.0.1.236``` is unreachable, you need to append this to the end of the variable's default value list like this:

```linkerd_additional_configuration_values = ["clusterNetworks: 10.0.0.0/8,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16,13.0.1.236/24"]```

Then, run ```terraform apply -var="kubernetes_config_context=<CLUSTER_ARN>"``` again from the ```eks/cluster-setup``` directory to update the Linkerd control plane with this setting.

3) Run a ```linkerd check``` again to ensure that the check for ```cluster networks contains all pods``` succeeds.

4) Run ```linkerd viz dashboard &```. This will automatically open up the Linkerd Dashboard on a new tab in your browser at a localhost port. This process can take up to 30 seconds.
