variable namespace_annotations {
  type = map(string)
  description = "Map of annotations applied to the created namespace"
  default = {
    "linkerd.io/inject" = "enabled"
  }
}
