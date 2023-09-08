locals {
    json_files = fileset(path.module, "collections/*.json")
    json_data  = [ for f in local.json_files : jsondecode(file("${path.module}/${f}")) ]
}

data "http" "ingest_collection" {
  for_each   = {
    for index, j in local.json_data:
    j.id => j
  }
  url    = "http://127.0.0.1:8080/collections"
  method = "POST"

  # Optional request headers
  request_headers = {
    Content-Type = "application/json"
  }

  # Optional request body
  request_body = jsonencode(each.value)
}