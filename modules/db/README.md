# DB

This module defines the resources required to support a state database for SWOOP: STAC Workflow Open Orchestration Platform. This includes:

- [Postgres](./postgres/README.md): a database service to store the state database of [SWOOP API](https://github.com/Element84/swoop). The helm chart for MinIO can be found at: [https://github.com/Element84/filmdrop-k8s-helm-charts/](https://github.com/Element84/filmdrop-k8s-helm-charts/)

<br></br>
***To run Postgres with SWOOP API check the [SWOOP API Guide](../swoop/README.md).***

<br></br>
## Installation
***Please run the following steps at the top level of the filmdrop-k8s-tf-modules project.***

***For recommended VM settings and other kubernetes guidance, please check the [Operations Guide](../../operations/Operations_Guide.md)***

***The commands below require you to be on top level directory of the filmdrop-k8s-tf-modules project.***


1. First, update [local.tfvars](../../local.tfvars) or create your own .tfvars:
* For enabling postgres you will need to enable at least the following from your tfvars:
```
deploy_postgres           = true
deploy_db_init            = true
```
* If you would like to automatically expose the swoop-api, minio and postgres ports in your local environment, you can enable an ingress-nginx that has been provided for this purpose. First for enabling the ingress-nginx module, make sure to update [local.tfvars](../../local.tfvars) or your own .tfvars with the following:
```
deploy_ingress_nginx      = true
```
* Lastly, if you do decide to use the ingress-nginx load balancer to expose your application, you can control which local port would you want to forward the service port via the nginx_extra_values variable in the [local.tfvars](../../local.tfvars) or your own .tfvars:
```
nginx_extra_values = {
  "tcp.<LOCAL_MACHINE_PORT>" = "<NAMESPACE>/<SERVICE_NAME>:<SERVICE_PORT>"
}
```
* For postgres, the default nginx_extra_values configuration would look like:
```
nginx_extra_values = {
  "tcp.5432"  = "db/postgres:5432"
}
```

2. Next, initialize terraform:

```bash
terraform init
```

3. Validate that the terraform resources are valid. If your terraform is valid the validate command will respond with _"Success! The configuration is valid."_

```bash
terraform validate
```

4. Run a terraform plan. The terraform plan will give you a summary of all the changes terraform will perform prior to deploying any change. You will a need 

```bash
terraform plan -var-file=local.tfvars
```

5. Deploy the changes by applying the terraform plan. You will be asked to confirm the changes and must respond with _"yes"_.

```bash
terraform apply -var-file=local.tfvars
```

## Connecting to Postgres

### Connecting with Ingress Nginx

If you decided to enable the ingress-nginx module, then you do not need to do anything else to expose your service ports! You should be able to reach out your services via your localhost without the need of port-forwarding. For example:
```
postgres:5432 -> localhost:5432
```
### Connecting without Ingress Nginx
Once the chart has been deployed, you should see at least 1 deployment for postgres.
<br></br>
<p align="center">
  <img src="./images/postgres-deployment-services.png" alt="Postgres Deployment" width="1776">
</p>
<br></br>

In order to start using the services used by this helm chart, you will need to port-forward `postgres` onto localhost port `5432`.

Via Rancher Desktop:
<br></br>
<p align="center">
  <img src="./images/postgres-port-forwarding.png" alt="Port forwarding Postgres" width="1776">
</p>
<br></br>

or via terminal:
```
kubectl port-forward -n db svc/postgres 5432:5432 &
```
## Test connection to postgres database

For a comprehensive set of steps initialize and use the postgres database, please refer to the swoop-db repo [https://github.com/Element84/swoop-db](https://github.com/Element84/swoop-db).

To test the connection to the postgres database, export the following postgres environment variables:
```
export PGHOST="127.0.0.1"
export PGUSER="`kubectl get secret -n db postgres-secret-admin-role -o jsonpath='{.data.username}' | base64 -D`"
export PGPASSWORD="`kubectl get secret -n db postgres-secret-admin-role -o jsonpath='{.data.password}' | base64 -D`"
export PGPORT="`helm get values postgres -n db -a -o json | jq -r .service.port`"
export PGDATABASE="`helm get values postgres -n db -a -o json | jq -r .service.dbName`"
export PGAUTHMETHOD="trust"

```

Then connect to the postgres database by running a psql command:
```
$ psql -p $PGPORT -U $PGUSER $PGDATABASE

psql (14.7 (Homebrew), server 15.3 (Debian 15.3-1.pgdg110+1))
WARNING: psql major version 14, server major version 15.
         Some psql features might not work.
Type "help" for help.

swoop=#
```

## Retrieving SWOOP credentials
Credentials can be retrieved by looking at the secrets created in the `db` namespace:
```
kubectl get secrets -n db
NAME                                  TYPE                 DATA   AGE
postgres-secret-caboose-role          Opaque               2      12m
postgres-secret-owner-role            Opaque               2      12m
postgres-secret-conductor-role        Opaque               2      12m
postgres-secret-admin-role            Opaque               2      12m
postgres-secret-api-role              Opaque               2      12m
sh.helm.release.v1.postgres.v1        helm.sh/release.v1   1      12m
sh.helm.release.v1.swoop-db-init.v1   helm.sh/release.v1   1      11m
```

To see the individual credential value you can export them the following way
```
export PGADMINUSER=`kubectl get secret -n db postgres-secret-admin-role -o jsonpath='{.data.username}' | base64 -D`
export PGADMINPASS=`kubectl get secret -n db postgres-secret-admin-role -o jsonpath='{.data.password}' | base64 -D`
export PGOWNERUSER=`kubectl get secret -n db postgres-secret-owner-role -o jsonpath='{.data.username}' | base64 -D`
export PGOWNERPASS=`kubectl get secret -n db postgres-secret-owner-role -o jsonpath='{.data.password}' | base64 -D`
export PGAPIUSER=`kubectl get secret -n db postgres-secret-api-role -o jsonpath='{.data.username}' | base64 -D`
export PGAPIPASS=`kubectl get secret -n db postgres-secret-api-role -o jsonpath='{.data.password}' | base64 -D`
export PGCABOOSEUSER=`kubectl get secret -n db postgres-secret-caboose-role -o jsonpath='{.data.username}' | base64 -D`
export PGCABOOSEPASS=`kubectl get secret -n db postgres-secret-caboose-role -o jsonpath='{.data.password}' | base64 -D`
export PGCONDUCTORUSER=`kubectl get secret -n db postgres-secret-conductor-role -o jsonpath='{.data.username}' | base64 -D`
export PGCONDUCTORPASS=`kubectl get secret -n db postgres-secret-conductor-role -o jsonpath='{.data.password}' | base64 -D`
```

## Uninstall postgres

To uninstall the release, do `terraform destroy -var-file=local.tfvars`.

