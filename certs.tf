# To do automatic mutual TLS, Linkerd requires trust anchor
# certificate and an issuer certificate and key pair. When you’re
# using linkerd install, we can generate these for you. However,
# for Helm, we need to explicitly generate them, and in this case
# we're using the Terraform TLS provider for this purpose.
# Reference: https://linkerd.io/2.12/tasks/install-helm/#linkerd-control-plane

resource "tls_private_key" "trustanchor_key" { 
  count = var.local_or_eks == "eks" ? 0 : 1
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "trustanchor_cert" {  
  count = var.local_or_eks == "eks" ? 0 : 1
  private_key_pem       = tls_private_key.trustanchor_key[0].private_key_pem
  validity_period_hours = var.cert_validity_period_hours
  is_ca_certificate     = true

  subject {
    common_name = "identity.linkerd.cluster.local"
  }

  allowed_uses = [
    "crl_signing",
    "cert_signing",
    "server_auth",
    "client_auth"
  ]
}

resource "tls_private_key" "issuer_key" {  
  count = var.local_or_eks == "eks" ? 0 : 1
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_cert_request" "issuer_req" {  
  count = var.local_or_eks == "eks" ? 0 : 1
  private_key_pem = tls_private_key.issuer_key[0].private_key_pem

  subject {
    common_name = "identity.linkerd.cluster.local"
  }
}

resource "tls_locally_signed_cert" "issuer_cert" {  
  count = var.local_or_eks == "eks" ? 0 : 1
  cert_request_pem      = tls_cert_request.issuer_req[0].cert_request_pem
  ca_private_key_pem    = tls_private_key.trustanchor_key[0].private_key_pem
  ca_cert_pem           = tls_self_signed_cert.trustanchor_cert[0].cert_pem
  validity_period_hours = var.cert_validity_period_hours
  is_ca_certificate     = true

  allowed_uses = [
    "crl_signing",
    "cert_signing",
    "server_auth",
    "client_auth"
  ]
}
