# FilmDrop Kubernetes Terraform Infrastructure Modules

This repository contains the packaging of FilmDrop terraform modules with Kubernetes.

This FilmDrop repository manages the supporting infrastructure required to deploy the [STAC Workflow Open Orchestration Platform (SWOOP)](https://github.com/Element84/swoop). The terraform modules utilize the [FilmDrop Kubernetes Helm Charts](https://github.com/Element84/filmdrop-k8s-helm-charts) to deploy the FilmDrop resources on Kubernetes clusters.

## Pre-requisites

For local or AWS environment pre-requisites, head to the [Operations Manual](./operations/Operations_Guide.md).

## Components

### Linkerd

The local development environment includes Linkerd as a service mesh. More information is available [here](./modules/service_mesh/README.md).

You can configure whether or not Linkerd is included in deployment by setting the `deploy_linkerd` flag in the [inputs](./inputs.tf) file.
<br></br>

### Nginx ingress proxy

An nginx ingress proxy has been added by default to the local development environment More information is available [here](./modules/ingress/README.md).

You can configure whether or not Ingress NGINX is included in deployment by setting the `deploy_ingress_nginx` flag in the [inputs](./inputs.tf) file.
<br></br>

### Monitoring

The local development environment includes resources for aggregating and visualizing logs and metrics. This includes:

- [Grafana](https://grafana.com/grafana/) for visualization and dashboards. You can configure whether or not grafana is included in deployment by setting the `deploy_grafana_prometheus` flag in the [inputs](./inputs.tf) file.
- [Prometheus](https://grafana.com/oss/prometheus/) for metric monitoring. You can configure whether or not prometheus is included in deployment by setting the `deploy_grafana_prometheus` flag in the [inputs](./inputs.tf) file.
- [Loki](https://grafana.com/oss/loki/) for log storage and disovery. You can configure whether or not loki is included in deployment by setting the `deploy_loki` flag in the [inputs](./inputs.tf) file.
- [Promtail](https://grafana.com/docs/loki/latest/clients/promtail/) for log scraping. You can configure whether or not loki is included in deployment by setting the `deploy_promtail` flag in the [inputs](./inputs.tf) file.


More information is available [here](./modules/monitoring/README.md).

<br></br>

### IO

The IO module includes [MinIO](https://min.io/), an S3 compatible object storage for the usage of the [SWOOP API](https://github.com/Element84/swoop), [SWOOP Caboose](https://github.com/Element84/swoop-go), and [SWOOP Conductor](https://github.com/Element84/swoop-go). More information is available [here](./modules/io/README.md).

You can configure whether or not STAC-FastAPI is included in deployment by setting the `deploy_minio` flag in the [inputs](./inputs.tf) file.
<br></br>

### DB

The DB module includes [PostgreSQL](https://www.postgresql.org/), an open source object-relational database system for the usage of the [SWOOP API](https://github.com/Element84/swoop), [SWOOP Caboose](https://github.com/Element84/swoop-go), and [SWOOP Conductor](https://github.com/Element84/swoop-go). More information is available [here](./modules/db/README.md).

You can configure whether or not Postgres is included in deployment by setting the `deploy_postgres` flag in the [inputs](./inputs.tf) file.

The DB module also has a configurable swoop-db-init which will initialize [swoop-db](https://github.com/Element84/swoop-db) with the creation of a SWOOP database and Roles for each SWOOP Component. You can configure whether or not swoop-db-init is included in deployment by setting the `deploy_db_init` flag in the [inputs](./inputs.tf) file.
<br></br>

### STAC-FastAPI

The local development environment includes a module for deploying STAC-FastAPI, which provides an API that exposes a STAC catalog that is persisted in a backend Postgres database with its component STAC Collections and Items. More information is available [here](./modules/stac-fastapi/README.md).

You can configure whether or not STAC-FastAPI is included in deployment by setting the `deploy_stacfastapi` flag in the [inputs](./inputs.tf) file.
<br></br>

### SWOOP

The swoop module contains the SWOOP Bundle which will install the followin the following components into a kubernetes cluster:
* [swoop-api](https://github.com/Element84/swoop) - configure whether or not SWOOP-API is included in deployment by setting the `deploy_swoop_api` flag in the [inputs](./inputs.tf) file
* [argo-workflows](https://github.com/argoproj/argo-workflows/) - configure whether or not SWOOP-API is included in deployment by setting the `deploy_argo_workflows` flag in the [inputs](./inputs.tf) file
* [swoop-caboose](https://github.com/Element84/swoop-go) - configure whether or not SWOOP-API is included in deployment by setting the `deploy_swoop_caboose` flag in the [inputs](./inputs.tf) file
* [swoop-conductor](https://github.com/Element84/swoop-go) - configure whether or not SWOOP-API is included in deployment by setting the `deploy_swoop_conductor` flag in the [inputs](./inputs.tf) file

The SWOOP Bundle is inteded to group all SWOOP components compatible with the same database schema version and it's related migration operations. More information is available [here](./modules/swoop/README.md).

The SWOOP Bundle also has a configurable swoop-db-migration which will migrate forward or backwards a schema version of the [swoop-db](https://github.com/Element84/swoop-db) in support of the SWOOP Components. You can configure whether or not swoop-db-migration is included in deployment by setting the `deploy_db_migration` flag in the [inputs](./inputs.tf) file.
<br></br>

### Tiling

The local development environment includes resources for rendering and serving tiles. More information is available [here](./modules/tiling/README.md).

**Currently Titiler does not distribute a docker image for an ARM architecture. If you're running an Apple silicon (M1, M2) or similar machine you should skip installation of the tiling namespace.**

You can configure whether or not tiling resources are included in deployment by setting the `deploy_tiling` flag in the [inputs](./inputs.tf) file.
<br></br>

### Profiles

To view and extend profiles, head [here](./profiles/README.md).
<br></br>

# `flop` CLI
## What is `flop`?

`flop` is a utility for creating and interacting with FilmDrop-on-K8s test environments. The name is a portmanteau of FiLmdrOP.

## Dependencies and Setup

* Bash &nbsp;<sub><sup>(versions tested: 5, 3.2)<sub><sup>
* Container Manager &nbsp;<sub><sup>(e.g. Docker Desktop, Colima)<sub><sup>
* `kind` and/or `k3d`
* kubectl
* terraform

On Mac, install any missing dependencies with:

```shell
brew install colima terraform k3d kubectl
colima start
```

Other useful tools:

* helm cli
* linkerd (required for current tests)
* lima (if using colima, sometimes helpful for lower-level troubleshooting)
* shellcheck (for checking `flop` scripts when developing)
<br><br>

## Using `flop`

### Run `flop` to list all of the available features:

```shell
./flop
```

### A typical example of a `flop` workflow:

```shell
CLUSTER="$(flop create)"  # stdout contains cluster name

flop terraform "${CLUSTER}" apply -var-file ./flop.tfvars -auto-approve

flop kubectl "${CLUSTER}" get svc -A

flop test "${CLUSTER}"

flop destroy "${CLUSTER}"
```

### If things go sideways, you can delete the entire state:

```shell
flop destroy --all
```
<br>

## `flop` tests

Right now the test functionality is pretty limited. We should likely consider
using a test framework with more expressivity and control like `pytest`. That
said, the `test` command will run any executables found in the `flop.d/tests`
directory.

Please extend the existing test scripts or add new ones, as necessary.
<br><br>

