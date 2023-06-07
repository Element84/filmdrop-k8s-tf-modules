output values {
    value = lookup(helm_release.minio.metadata[0], "values")
}
