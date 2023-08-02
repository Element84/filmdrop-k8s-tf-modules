resource "kubernetes_job_v1" "db-initialization" {
  count = var.deploy_db_init == true ? 1 : 0
  metadata {
    name      = "db-initialization"
    namespace = var.namespace
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "swoop-db"
          image   = "${var.custom_input_map["postgres.image.repository"]}:${var.custom_input_map["postgres.image.tag"]}"
          command = ["python", "/opt/swoop/db/scripts/db-initialization.py"]

          env {
            name  = "PGHOST"
            value = var.custom_input_map["postgres.service.name"]
          }

          env {
            name  = "PGUSER"
            value = base64decode(var.custom_input_map["postgres.service.dbUser"])
          }

          env {
            name  = "PGDATABASE"
            value = var.custom_input_map["postgres.service.dbName"]
          }

          env {
            name  = "PGPORT"
            value = var.custom_input_map["postgres.service.port"]
          }

          env {
            name = "API_ROLE_USER"
            value_from {
              secret_key_ref {
                name = "postgres-secret-api-role"
                key  = "username"
              }
            }
          }
          env {
            name = "API_ROLE_PASS"
            value_from {
              secret_key_ref {
                name = "postgres-secret-api-role"
                key  = "password"
              }
            }
          }
          env {
            name = "CABOOSE_ROLE_USER"
            value_from {
              secret_key_ref {
                name = "postgres-secret-caboose-role"
                key  = "username"
              }
            }
          }
          env {
            name = "CABOOSE_ROLE_PASS"
            value_from {
              secret_key_ref {
                name = "postgres-secret-caboose-role"
                key  = "password"
              }
            }
          }
          env {
            name = "CONDUCTOR_ROLE_USER"
            value_from {
              secret_key_ref {
                name = "postgres-secret-conductor-role"
                key  = "username"
              }
            }
          }
          env {
            name = "CONDUCTOR_ROLE_PASS"
            value_from {
              secret_key_ref {
                name = "postgres-secret-conductor-role"
                key  = "password"
              }
            }
          }

          env {
            name = "OWNER_ROLE_USER"
            value_from {
              secret_key_ref {
                name = "postgres-secret-owner-role"
                key  = "username"
              }
            }
          }
          env {
            name = "OWNER_ROLE_PASS"
            value_from {
              secret_key_ref {
                name = "postgres-secret-owner-role"
                key  = "password"
              }
            }
          }

        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 4
  }
  wait_for_completion = true
  timeouts {
    create = "2m"
    update = "2m"
  }

  depends_on = [
    kubernetes_secret.db_postgres_secret_owner_role,
    kubernetes_secret.db_postgres_secret_api_role,
    kubernetes_secret.db_postgres_secret_caboose_role,
    kubernetes_secret.db_postgres_secret_conductor_role
  ]
}
