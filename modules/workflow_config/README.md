# Workflow configuration resources

This module installs resources that deploy the SWOOP configuration file and workflow template files used by Argo Workflows to run workflows on the cluster.

## Installation

Update the `local.tfvars` file to:

```
deploy_linkerd            = false
deploy_ingress_nginx      = false
deploy_grafana_prometheus = false
deploy_loki               = false
deploy_promtail           = false
deploy_argo_workflows     = true
deploy_titiler            = false
deploy_stacfastapi        = false
deploy_swoop_api          = false
deploy_swoop_caboose      = true
deploy_db_migration       = true
deploy_postgres           = true
deploy_db_init            = true
deploy_minio              = true
deploy_workflow_config    = true
```

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
terraform apply --var-file=local.tfvars
```

Once the chart has been deployed, you can do:

`kubectl get workflowtemplate -n swoop` and

`kubectl get configmap -n swoop`

to see that the workflow templates and SWOOP configmap that were deployed.
