module "namespace" {
  count   = var.create_namespace == true ? 1 : 0
  source  = "./namespace"

  namespace_annotations   = var.namespace_annotations
  namespace               = var.namespace
}
