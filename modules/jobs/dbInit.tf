resource "kubernetes_job_v1" "db-initialization" {
  metadata {
    name      = "db-initialization"
    namespace = "db"
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "swoop-db"
          image   = "quay.io/element84/swoop-db"
          command = ["python", "opt/swoop/db/scripts/db-initialization.py"]
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
}
