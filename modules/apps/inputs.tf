variable deploy_hello_world {
  type        = bool
  default     = true
  description = "Deploy Hello World app"
}

variable namespace_annotations {
  type        = map(string)
  description = "MAP of custom defined namespace annotations"
}
