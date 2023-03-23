# ================ common variables (required) ================

variable "helm_repo_url" {
  type        = string
  default     = "https://helm.linkerd.io/stable"
  description = "Helm repository"
}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Create the namespace if it does not yet exist"
}

variable "namespace" {
  type        = string
  default     = "linkerd"
  description = "The K8s namespace in which the linkerd service account has been created"
}

# ================ helm release variables (required) ================

variable "helm_repo_key_file" {
  type        = string
  default     = ""
  description = "Helm repositories cert key file"
}

variable "helm_repo_cert_file" {
  type        = string
  default     = ""
  description = "Helm repositories cert file"
}

variable "helm_repo_ca_file" {
  type        = string
  default     = ""
  description = "Helm repositories cert file"
}

variable "helm_repo_username" {
  type        = string
  default     = ""
  description = "Username for HTTP basic authentication against the helm repository"
}

variable "helm_repo_password" {
  type        = string
  default     = ""
  description = "Password for HTTP basic authentication against the helm repository"
}

# ================ crd variables ================

variable "crds_helm_chart_name" {
  type        = string
  default     = "linkerd-crds"
  description = "Helm chart name to be installed"
}

variable "crds_helm_chart_version" {
  type        = string
  default     = "1.4.0"
  description = "Version of the Helm chart"
}

variable "crds_helm_release_name" {
  type        = string
  default     = "linkerd-crds"
  description = "Helm release name"
}

variable "crds_settings" {
  type        = map(any)
  default     = {}
  description = "Additional helm sets which will be passed to the Helm chart values, see https://artifacthub.io/packages/helm/linkerd2/linkerd2"
}

variable "crds_values" {
  type        = string
  default     = ""
  description = "Additional yaml encoded values which will be passed to the Helm chart, see https://artifacthub.io/packages/helm/linkerd2/linkerd2"
}


variable "crds_helm_devel" {
  type        = bool
  default     = false
  description = "Use helm chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored"
}

variable "crds_helm_package_verify" {
  type        = bool
  default     = false
  description = "Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart"
}

variable "crds_helm_keyring" {
  type        = string
  default     = "~/.gnupg/pubring.gpg"
  description = "Location of public keys used for verification. Used only if helm_package_verify is true"
}

variable "crds_helm_timeout" {
  type        = number
  default     = 300
  description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks)"
}

variable "crds_helm_disable_webhooks" {
  type        = bool
  default     = false
  description = "Prevent helm chart hooks from running"
}

variable "crds_helm_reset_values" {
  type        = bool
  default     = false
  description = "When upgrading, reset the values to the ones built into the helm chart"
}

variable "crds_helm_reuse_values" {
  type        = bool
  default     = false
  description = "When upgrading, reuse the last helm release's values and merge in any overrides. If 'helm_reset_values' is specified, this is ignored"
}

variable "crds_helm_force_update" {
  type        = bool
  default     = false
  description = "Force helm resource update through delete/recreate if needed"
}

variable "crds_helm_recreate_pods" {
  type        = bool
  default     = false
  description = "Perform pods restart during helm upgrade/rollback"
}

variable "crds_helm_cleanup_on_fail" {
  type        = bool
  default     = false
  description = "Allow deletion of new resources created in this helm upgrade when upgrade fails"
}

variable "crds_helm_release_max_history" {
  type        = number
  default     = 0
  description = "Maximum number of release versions stored per release"
}

variable "crds_helm_atomic" {
  type        = bool
  default     = false
  description = "If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used"
}

variable "crds_helm_wait" {
  type        = bool
  default     = false
  description = "Will wait until all helm release resources are in a ready state before marking the release as successful. It will wait for as long as timeout"
}

variable "crds_helm_wait_for_jobs" {
  type        = bool
  default     = false
  description = "If wait is enabled, will wait until all helm Jobs have been completed before marking the release as successful. It will wait for as long as timeout"
}

variable "crds_helm_wait_for_crds_duration" {
  type        = string
  default     = "30s"
  description = "Time duration to delay control plane helm release creation after crds helm release. For example, `30s` for 30 seconds or `5m` for 5 minutes. Updating this value by itself will not trigger a delay."
}

variable "crds_helm_skip_crds" {
  type        = bool
  default     = false
  description = "If set, no CRDs will be installed before helm release"
}

variable "crds_helm_render_subchart_notes" {
  type        = bool
  default     = true
  description = "If set, render helm subchart notes along with the parent"
}

variable "crds_helm_disable_openapi_validation" {
  type        = bool
  default     = false
  description = "If set, the installation process will not validate rendered helm templates against the Kubernetes OpenAPI Schema"
}

variable "crds_helm_dependency_update" {
  type        = bool
  default     = false
  description = "Runs helm dependency update before installing the chart"
}

variable "crds_helm_replace" {
  type        = bool
  default     = false
  description = "Re-use the given name of helm release, only if that name is a deleted release which remains in the history. This is unsafe in production"
}

variable "crds_helm_description" {
  type        = string
  default     = ""
  description = "Set helm release description attribute (visible in the history)"
}

variable "crds_helm_lint" {
  type        = bool
  default     = false
  description = "Run the helm chart linter during the plan"
}

variable "crds_helm_set_sensitive" {
  type        = map(any)
  default     = {}
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff"
}

variable "crds_helm_postrender" {
  type        = map(any)
  default     = {}
  description = "Value block with a path to a binary file to run after helm renders the manifest which can alter the manifest contents"
}





# ================ control plane variables ================

variable "control_plane_helm_chart_name" {
  type        = string
  default     = "linkerd-control-plane"
  description = "Helm chart name to be installed"
}

variable "control_plane_helm_chart_version" {
  type        = string
  default     = "1.9.4"
  description = "Version of the Helm chart"
}

variable "control_plane_helm_release_name" {
  type        = string
  default     = "linkerd-control-plane"
  description = "Helm release name"
}

variable "control_plane_settings" {
  type        = map(any)
  default     = {}
  description = "Additional helm sets which will be passed to the Helm chart values, see https://artifacthub.io/packages/helm/linkerd2/linkerd2"
}

variable "control_plane_values" {
  type        = string
  default     = ""
  description = "Additional yaml encoded values which will be passed to the Helm chart, see https://artifacthub.io/packages/helm/linkerd2/linkerd2"
}


variable "control_plane_helm_devel" {
  type        = bool
  default     = false
  description = "Use helm chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored"
}

variable "control_plane_helm_package_verify" {
  type        = bool
  default     = false
  description = "Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart"
}

variable "control_plane_helm_keyring" {
  type        = string
  default     = "~/.gnupg/pubring.gpg"
  description = "Location of public keys used for verification. Used only if helm_package_verify is true"
}

variable "control_plane_helm_timeout" {
  type        = number
  default     = 300
  description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks)"
}

variable "control_plane_helm_disable_webhooks" {
  type        = bool
  default     = false
  description = "Prevent helm chart hooks from running"
}

variable "control_plane_helm_reset_values" {
  type        = bool
  default     = false
  description = "When upgrading, reset the values to the ones built into the helm chart"
}

variable "control_plane_helm_reuse_values" {
  type        = bool
  default     = false
  description = "When upgrading, reuse the last helm release's values and merge in any overrides. If 'helm_reset_values' is specified, this is ignored"
}

variable "control_plane_helm_force_update" {
  type        = bool
  default     = false
  description = "Force helm resource update through delete/recreate if needed"
}

variable "control_plane_helm_recreate_pods" {
  type        = bool
  default     = false
  description = "Perform pods restart during helm upgrade/rollback"
}

variable "control_plane_helm_cleanup_on_fail" {
  type        = bool
  default     = false
  description = "Allow deletion of new resources created in this helm upgrade when upgrade fails"
}

variable "control_plane_helm_release_max_history" {
  type        = number
  default     = 0
  description = "Maximum number of release versions stored per release"
}

variable "control_plane_helm_atomic" {
  type        = bool
  default     = false
  description = "If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used"
}

variable "control_plane_helm_wait" {
  type        = bool
  default     = false
  description = "Will wait until all helm release resources are in a ready state before marking the release as successful. It will wait for as long as timeout"
}

variable "control_plane_helm_wait_for_jobs" {
  type        = bool
  default     = false
  description = "If wait is enabled, will wait until all helm Jobs have been completed before marking the release as successful. It will wait for as long as timeout"
}

variable "control_plane_helm_skip_crds" {
  type        = bool
  default     = false
  description = "If set, no CRDs will be installed before helm release"
}

variable "control_plane_helm_render_subchart_notes" {
  type        = bool
  default     = true
  description = "If set, render helm subchart notes along with the parent"
}

variable "control_plane_helm_disable_openapi_validation" {
  type        = bool
  default     = false
  description = "If set, the installation process will not validate rendered helm templates against the Kubernetes OpenAPI Schema"
}

variable "control_plane_helm_dependency_update" {
  type        = bool
  default     = false
  description = "Runs helm dependency update before installing the chart"
}

variable "control_plane_helm_replace" {
  type        = bool
  default     = false
  description = "Re-use the given name of helm release, only if that name is a deleted release which remains in the history. This is unsafe in production"
}

variable "control_plane_helm_description" {
  type        = string
  default     = ""
  description = "Set helm release description attribute (visible in the history)"
}

variable "control_plane_helm_lint" {
  type        = bool
  default     = false
  description = "Run the helm chart linter during the plan"
}

variable "control_plane_helm_set_sensitive" {
  type        = map(any)
  default     = {}
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff"
}

variable "control_plane_helm_postrender" {
  type        = map(any)
  default     = {}
  description = "Value block with a path to a binary file to run after helm renders the manifest which can alter the manifest contents"
}

variable "control_plane_clusternetworks" {
  type        = string
  default     = "10.0.0.0/8,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16"
  description = "The cluster networks for which service discovery is performed"
}

variable "cert_validity_period_hours" {
  description = "The number of hours after initial issuing that the certificate will become invalid."
  type        = number
  default     = 8760 # 1 year
}

variable "kubernetes_config_file" {
  description = "Kubernetes config file path."
  type        = string
  default     = "~/.kube/config"
}

variable "kubernetes_config_context" {
  description = "Kubernetes config context."
  type        = string
}