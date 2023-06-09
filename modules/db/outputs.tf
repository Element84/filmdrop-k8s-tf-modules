output postgres_values {
    value = var.deploy_postgres ? jsondecode(module.postgres[0].values) : {}
}

output namespace {
    value = var.namespace
}
