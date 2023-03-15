resource "helm_release" "ingress_nginx" {
  name              = "ingress-nginx"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  version           = "4.5.2"
  namespace         = "ingress-nginx"
  create_namespace  = true
  wait              = true
  atomic            = true

  values = [file("${path.module}/nginx/nginx_ingress_values.yaml")]

  set {
    name  = "controller.podAnnotations.linkerd\\.io/inject"
    value = "enabled"
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = var.nginx_http_port
  }

  set {
    name  = "controller.service.nodePorts.https"
    value = var.nginx_https_port
  }

  depends_on = [
    helm_release.linkerd_crds,
    helm_release.linkerd_control_plane,
    helm_release.linkerd_viz
  ]
}

resource "null_resource" "wait_for_ingress_nginx_ready" {
  triggers = {
    key = helm_release.ingress_nginx.id
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the nginx ingress controller...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} wait \
        --namespace ${helm_release.ingress_nginx.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=120s
    EOF
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}
