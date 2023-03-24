locals {
  crds_values_default = yamlencode({
    # add default values here
  })
  control_plane_values_default = yamlencode({
    "clusterNetworks":"${var.control_plane_clusternetworks}"
  })
}

data "utils_deep_merge_yaml" "crds_values" {
  input = compact([
    local.crds_values_default,
    var.crds_values
  ])
}

data "utils_deep_merge_yaml" "control_plane_values" {
  input = compact([
    local.control_plane_values_default,
    var.control_plane_values
  ])
}

