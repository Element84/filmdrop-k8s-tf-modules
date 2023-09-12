#!/usr/bin/env python
"""
This script ingests STAC collections into a deployment of Stac-FastAPI running on a K8s cluster.
The cluster could be running on AWS EKS or locally.

Docs for Transaction Extension: https://github.com/stac-api-extensions/transaction#methods

"""

import json
import os
from typing import Dict
import urllib.request


# Format is http://{service-name}.{namespace-name}:{port}/collections
FASTAPI_ENDPOINT = "http://stac-fastapi-pgstac.stac:8080/collections"


def post_collection(values: Dict) -> None:
    """
    This makes HTTP POST requests to the /collections endpoint for stac-fastapi-pgStac.

    values       (dict):  the JSON object for the collection

    Returns -> None

    """

    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
    }

    data = json.dumps(values).encode("utf-8")

    try:
        req = urllib.request.Request(FASTAPI_ENDPOINT, data, headers)
        with urllib.request.urlopen(req) as f:
            res = f.read()
    except Exception as e:
        print(e)


def ingest_collections() -> None:
    """
    This loops over collection JSON files in a directory within the container,
    sending each file's content to the post_collection function.

    Returns -> None

    """

    # Directory containing collection JSON files
    collection_dir = "task/collections"

    for file in os.listdir(collection_dir):
        if file.endswith(".json"):
            full_filename = f"{collection_dir}/{file}"
            with open(full_filename, "r") as fi:
                dict = json.load(fi)
                post_collection(dict)


if __name__ == "__main__":
    ingest_collections()
