# STAC-FastAPI

This module ingests STAC collections into a deployment of Stac-FastAPI running on a Kubernetes cluster.

See [STAC-FastAPI](https://stac-utils.github.io/stac-fastapi/) for more details.

<br></br>
***To install and run STAC-FastAPI check the [STAC-FastAPI Installation Guide](../README.md).***

In order to ingest collections, HTTP POST requests are made to the */collections* endpoint.
The `collections` directory contains JSON files describing STAC collections. All of the JSON files inside this folder are looked at by the ingestor process. Place the JSON files for any new collections that you want to ingest into this folder (and make sure that they are valid according to the [STAC Collection Specification](https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md)). Currently, three sample JSON files for three different collections are provided- *aster*, *naip*, and *sentinel-2*.

In order to deploy the STAC collections onto K8s, ensure that the `deploy_stacfastapi` and `deploy_staccollection` in `local.tfvars` is set to `true`. This will deploy the Stac-FastAPI module first followed by the Stac-Collection module.
