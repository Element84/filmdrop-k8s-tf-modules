locals {
  directory_collections = "${path.module}/collections"
}

resource "kubernetes_config_map" "collections" {
  metadata {
    name = "collections"
    namespace = var.namespace
  }

  data = {
    for f in fileset(local.directory_collections, "*.json") :
    f => file(join("/", [local.directory_collections, f]))
  }
}

resource "kubernetes_config_map" "ingest_script" {
  metadata {
    name = "ingest-script"
    namespace = var.namespace
  }

  data = {
    for f in fileset(local.directory_collections, "task.py") :
    f => file(join("/", [local.directory_collections, f]))
  }
}

resource "kubernetes_job_v1" "create_collections" {
  metadata {
    name = "create-collections"
    namespace = var.namespace
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "create-collections"
          image   = "python:3.9-alpine"
          command = ["python3", "task/ingest/task.py"]
          env {
            name = "FASTAPI_HOST"
            value = "${var.fastapi_servicename}.${var.namespace}:${var.fastapi_serviceport}"
          }
          volume_mount {
            name = "collection-volume"
            mount_path = "task/collections"
          }
          volume_mount {
            name = "ingest-script"
            mount_path = "task/ingest"
          }
        }
        volume {
          name = "collection-volume"
          config_map {
            name = "collections"
          }
        }
        volume {
          name = "ingest-script"
          config_map {
            name = "ingest-script"
          }
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 4
  }
  wait_for_completion = false

  depends_on = [kubernetes_config_map.collections,
  kubernetes_config_map.ingest_script]

}