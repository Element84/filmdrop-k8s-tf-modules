resource "helm_release" "linkerd_crds" {
  name              = "linkerd-crds"
  namespace         = "linkerd"
  repository        = "https://helm.linkerd.io/stable"
  chart             = "linkerd-crds"
  version           = "1.4.0"
  atomic            = true
  create_namespace  = true
}

resource "helm_release" "linkerd_control_plane" {
  name       = "linkerd-control-plane"
  namespace  = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-control-plane"
  version    = "1.9.4"
  atomic     = true

  set {
    name  = "identityTrustAnchorsPEM"
    value = tls_self_signed_cert.trustanchor_cert.cert_pem
  }

  set {
    name  = "identity.issuer.crtExpiry"
    value = tls_locally_signed_cert.issuer_cert.validity_end_time
  }

  set {
    name  = "identity.issuer.tls.crtPEM"
    value = tls_locally_signed_cert.issuer_cert.cert_pem
  }

  set {
    name  = "identity.issuer.tls.keyPEM"
    value = tls_private_key.issuer_key.private_key_pem
  }


  values = concat(
    [var.high_availability ? file("${path.module}/linkerd2/values-ha.yaml") : ""],
    length(var.linkerd_additional_configuration_values) == 0 ? [] : var.linkerd_additional_configuration_values
  )

  depends_on = [
    helm_release.linkerd_crds
  ]
}

resource "helm_release" "linkerd_viz" {
  name       = "linkerd-viz"
  chart      = "linkerd-viz"
  namespace  = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  version    = "30.3.6"
  atomic     = true

  set {
    name  = "tap.replicas"
    value = var.high_availability ? 3 : 1
  }

  set {
    name  = "enablePodAntiAffinity"
    value = var.high_availability ? true : false
  }

  depends_on = [
    helm_release.linkerd_crds,
    helm_release.linkerd_control_plane
  ]
}
