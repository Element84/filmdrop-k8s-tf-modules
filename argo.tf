resource "kubernetes_namespace" "argo_other" {
  metadata {
    annotations = {
      "linkerd.io/inject" = "enabled"
    }

    labels = {
      app = "argo-other"
    }

    name = "argo-other"
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "kubernetes_namespace" "argo_workflows" {
  metadata {

    labels = {
      app = "argo-workflows"
    }

    name = "argo-workflows"
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "kubernetes_secret" "argo_postgres_config" {
  metadata {
    name = "argo-postgres-config"
    namespace = "argo-workflows"
  }

  data = {
    username = "postgres"
    password = "password"
  }

  depends_on = [
    kubernetes_namespace.argo_workflows
  ]

}

resource "kubernetes_secret" "my_minio_cred" {
  metadata {
    name = "my-minio-cred"
    namespace = "argo-workflows"
  }

  data = {
    accesskey = "admin"
    secretkey = "password"
  }

  depends_on = [
    kubernetes_namespace.argo_workflows
  ]

}

resource "kubernetes_config_map" "artifact_repositories" {
  metadata {
    name = "artifact-repositories"
    namespace = "argo-workflows"
  }

  data = {
    "artifact-repositories.yml" = file("${path.module}/charts/argo-workflows/artifact-repositories.yaml")
  }

  depends_on = [
    kubernetes_namespace.argo_workflows
  ]

}


resource "helm_release" "argo_postgres" {
  name              = "argo-postgres"
  namespace         = "argo-other"
  chart             = "./charts/argo-postgres"
  atomic            = true

  depends_on = [
    kubernetes_namespace.argo_other,
    kubernetes_namespace.argo_workflows,
    kubernetes_secret.argo_postgres_config
  ]
}

resource "helm_release" "argo_artifact_repo" {
  name              = "argo-artifact-repo"
  namespace         = "argo-other"
  chart             = "./charts/argo-artifact-repo"
  atomic            = true

  depends_on = [
    kubernetes_secret.my_minio_cred,
    kubernetes_config_map.artifact_repositories,
    helm_release.argo_postgres
  ]
}

resource "helm_release" "argo_workflows" {
  name              = "argo-workflows"
  namespace         = "argo-workflows"
  chart             = "argo-workflows"
  repository        = "https://argoproj.github.io/argo-helm"
  atomic            = true


  values = [
    file("${path.module}/charts/argo-workflows/values.yaml")
  ]

  depends_on = [
    helm_release.argo_artifact_repo,
    helm_release.argo_postgres
  ]
}