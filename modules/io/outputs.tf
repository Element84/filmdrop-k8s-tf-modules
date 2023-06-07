output minio_values {
    value = var.deploy_minio ? jsondecode(module.minio[0].values) : {}
}

output namespace {
    value = var.namespace
}
