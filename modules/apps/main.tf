module "hello_world" {
  count = var.deploy_hello_world == true ? 1 : 0
  source = "./hello_world"

  namespace_annotations = var.namespace_annotations
}
