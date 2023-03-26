resource "kubernetes_namespace" "hello_world" {
  metadata {
    annotations = {
      "linkerd.io/inject" = "enabled"
    }

    labels = {
      app = "hello-world"
    }

    name = "hello-world"
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "helm_release" "hello_world_v1" {
  name              = "hello-world-v1"
  namespace         = "hello-world"
  chart             = "${path.module}/charts/hello-world"
  atomic            = true

   set {
     name  = "service.type"
     value = "ClusterIP"
   }

   set {
     name  = "ingress.configured"
     value = "true"
   }

   set {
     name  = "ingress.host"
     value = "hello-world.local"
   }

   set {
     name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
     value = "nginx"
   }

   set {
     name  = "deployment.container.image.tag"
     value = "1.0"
   }

  depends_on = [
    kubernetes_namespace.hello_world,
    helm_release.ingress_nginx
  ]
}

resource "helm_release" "hello_world_v2" {
  name              = "hello-world-v2"
  namespace         = "hello-world"
  chart             = "${path.module}/charts/hello-world"
  atomic            = true

   set {
     name  = "service.type"
     value = "ClusterIP"
   }

   set {
     name  = "ingress.configured"
     value = "true"
   }
   set {
     name  = "ingress.host"
     value = "hello-world.local"
   }

   set {
     name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
     value = "nginx"
   }

   set {
     name  = "deployment.container.image.tag"
     value = "2.0"
   }

  depends_on = [
    kubernetes_namespace.hello_world,
    helm_release.ingress_nginx
  ]
}

resource "kubernetes_ingress_v1" "hello_world_ingress_rule" {
  wait_for_load_balancer = true
  metadata {
    name        = "hello-world-ingress"
    namespace   = "hello-world"
     annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target"        = "/"
      "nginx.ingress.kubernetes.io/ssl-redirect"          = "false"
      "nginx.ingress.kubernetes.io/use-regex"             = "true"
      "nginx.ingress.kubernetes.io/service-upstream"      = "true"
      "ingress.kubernetes.io/ingress.class"               = "nginx"
      "nginx.ingress.kubernetes.io/backend-protocol"      = "HTTP"
      "nginx.ingress.kubernetes.io/from-to-www-redirect"  = "true"
      "kubernetes.io/tls-acme"                            = "false"
    }
  }

  spec {
    ingress_class_name = "nginx"

    default_backend {
      service {
        name = "hello-world-hello-world-v1"
        port {
          number = 80
        }
      }
    }

    rule {
      host = "hello-world.local"
      http {
        path {
          backend {
            service {
              name = "hello-world-hello-world-v1"
              port {
                number = 80
              }
            }
          }
          path                = "/v1"
          path_type           = "Prefix"
        }
        path {
          backend {
            service {
              name = "hello-world-hello-world-v2"
              port {
                number = 80
              }
            }
          }
          path                = "/v2"
          path_type           = "Prefix"
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.hello_world,
    helm_release.hello_world_v1,
    helm_release.hello_world_v2,
    helm_release.ingress_nginx,
    null_resource.wait_for_ingress_nginx_ready
  ]
}
