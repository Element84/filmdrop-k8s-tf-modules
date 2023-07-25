resource "helm_release" "ingress_nginx" {
  name              = "ingress-nginx"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  version           = var.ingress_nginx_version
  namespace         = var.namespace
  create_namespace  = false
  atomic            = true

  dynamic "set" {
    for_each = var.extra_values

    content {
      name = set.key
      value = set.value
    }
  }

  values = concat(
    [var.custom_ingress_nginx_values_yaml == "" ? file("${path.module}/values.yaml") : file(var.custom_ingress_nginx_values_yaml)],
    length(var.ingress_nginx_additional_configuration_values) == 0 ? [] : var.ingress_nginx_additional_configuration_values
  )
}

resource "null_resource" "wait_for_ingress_nginx_ready" {
  triggers = {
    key = helm_release.ingress_nginx.id
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the nginx ingress controller...\n"
      kubectl --kubeconfig ${var.kubernetes_config_file} \
        --context '${var.kubernetes_config_context}' wait \
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
