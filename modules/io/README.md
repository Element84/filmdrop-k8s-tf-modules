# IO

This module defines the resources required to support object storage for SWOOP: STAC Workflow Open Orchestration Platform. This includes:

- [MinIO](./minio/README.md): an object storage service for storing artifacts from the [SWOOP API](https://github.com/Element84/swoop). The helm chart for MinIO can be found at: [https://github.com/Element84/filmdrop-k8s-helm-charts/](https://github.com/Element84/filmdrop-k8s-helm-charts/)


<br></br>
***To run MinIO with SWOOP API check the [SWOOP API Guide](../swoop/README.md).***

<br></br>
## Installation
***Please run the following steps at the top level of the filmdrop-k8s-tf-modules project.***

***For recommended VM settings and other kubernetes guidance, please check the [Operations Guide](../../operations/Operations_Guide.md)***

1. First, initialize terraform:

```bash
terraform init
```

2. Validate that the terraform resources are valid. If your terraform is valid the validate command will respond with _"Success! The configuration is valid."_

```bash
terraform validate
```

3. Run a terraform plan. The terraform plan will give you a summary of all the changes terraform will perform prior to deploying any change.

```bash
terraform plan -var-file=local.tfvars
```

4. Deploy the changes by applying the terraform plan. You will be asked to confirm the changes and must respond with _"yes"_.

```bash
terraform apply -var-file=local.tfvars
```

## Port-forwarding MinIO
Once the chart has been deployed, you should see at least 1 deployment for minio.
<br></br>
<p align="center">
  <img src="./images/minio-deployment-services.png" alt="MinIO Deployment" width="1776">
</p>
<br></br>

In order to start using the services used by this helm chart, you will need to port-forward `minio` onto localhost port `9000` & `9001`.
<br></br>
<p align="center">
  <img src="./images/minio-port-forwarding.png" alt="Port forwarding MinIO" width="1776">
</p>
<br></br>

## Setting up MinIO CLI


### Install First the MinIO client by running:
```
brew install minio/stable/mc
```

### Then set the MinIO alias, find the ACCESS_KEY and SECRET_KEY by quering the Helm values
```
export MINIO_ACCESS_KEY=`helm get values minio -n io -a -o json | jq -r .minio.service.accessKeyId | base64 --decode`
export MINIO_SECRET_KEY=`helm get values minio -n io -a -o json | jq -r .minio.service.secretAccessKey | base64 --decode`
mc alias set minio http://127.0.0.1:9000 $MINIO_ACCESS_KEY $MINIO_SECRET_KEY
```

### Test MinIO connection by running:
```
$ mc admin info minio

●  127.0.0.1:9000
   Uptime: 4 minutes
   Version: 2023-06-02T23:17:26Z
   Network: 1/1 OK
   Drives: 1/1 OK
   Pool: 1

Pools:
   1st, Erasure sets: 1, Drives per erasure set: 1

0 B Used, 1 Bucket, 0 Objects
1 drive online, 0 drives offline
```

## Log into MinIO Dashboard
Retrieve username by running:
```
helm get values minio -n io -a -o json | jq -r .minio.service.accessKeyId | base64 --decode
```

Retrieve password by running:
```
helm get values minio -n io -a -o json | jq -r .minio.service.secretAccessKey | base64 --decode
```

Open MinIO dashboard by opening your browser on [http://localhost:9001/](http://localhost:9001/) and logging into MinIO using the credentials above:
<p align="center">
  <img src="./images/minio-dashboard.png" alt="SWOOP MinIO" width="1776">
</p>
<br></br>


## Uninstall minio

To uninstall the release, do `terraform destroy`.
