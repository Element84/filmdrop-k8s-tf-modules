# Workflow configuration resources

This module installs resources that deploy the SWOOP configuration file and workflow template files used by Argo Workflows to run workflows on the cluster.

## Installation

1. First, initialize Terraform:

```bash
terraform init
```

2. Validate that the terraform resources are valid. If your Terraform configuration is valid the validate command will respond with _"Success! The configuration is valid."_

```bash
terraform validate
```

3. Run terraform plan. The terraform plan will give you a summary of all the changes Terraform will perform prior to deploying any change.

```bash
terraform plan
```

4. Deploy the changes by applying terraform plan. You will be asked to confirm the changes and must respond with _"yes"_.

```bash
terraform apply
```

Once installed you can verify STAC-FastAPI is running by first port-forwarding the PgSTAC service:

`kubectl port-forward service/pgstac 5439:5439`

followed by port-forwarding the STAC-FastAPI application service:

`kubectl port-forward service/stac-fastapi-pgstac 8080:8080`

Then, with your browser of choice navigate to `http://localhost:8080`.
