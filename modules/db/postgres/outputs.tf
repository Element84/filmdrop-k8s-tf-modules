output values {
    value = lookup(helm_release.postgres.metadata[0], "values")
}
