#######################
## Standard variables
#######################

variable "cluster_name" {
  description = "Name given to the cluster. Value used for naming some the resources created by the module."
  type        = string
  default     = "cluster"
}

variable "base_domain" {
  description = "Base domain of the cluster. Value used for the ingress' URL of the application."
  type        = string
  default     = null
}

variable "cluster_issuer" {
  description = "SSL certificate issuer to use. Usually you would configure this value as `letsencrypt-staging` or `letsencrypt-prod` on your root `*.tf` files."
  type        = string
  default     = "ca-issuer"
}

variable "argocd_namespace" {
  description = "Namespace used by Argo CD where the Application and AppProject resources should be created."
  type        = string
  default     = "argocd"
}

variable "target_revision" {
  description = "Override of target revision of the application chart."
  type        = string
  default     = "v1.0.0" # x-release-please-version
}

variable "namespace" {
  description = "Namespace where the applications's Kubernetes resources should be created. Namespace will be created in case it doesn't exist."
  type        = string
  default     = "longhorn-system"
}

variable "helm_values" {
  description = "Helm chart value overrides. They should be passed as a list of HCL structures."
  type        = any
  default     = []
}

variable "app_autosync" {
  description = "Automated sync options for the Argo CD Application resource."
  type = object({
    allow_empty = optional(bool)
    prune       = optional(bool)
    self_heal   = optional(bool)
  })
  default = {
    allow_empty = false
    prune       = true
    self_heal   = true
  }
}

variable "dependency_ids" {
  description = "IDs of the other modules on which this module depends on."
  type        = map(string)
  default     = {}
}

#######################
## Module variables
#######################

variable "storage_over_provisioning_percentage" {
  description = "Set the storage over-provisioning percentage. **This values should be modified only when really needed.** The default is 200%, as https://longhorn.io/docs/1.3.1/best-practices/#minimal-available-storage-and-over-provisioning[recommended in the best practices] for single-disk nodes."
  type        = number
  default     = 200
}

variable "storage_minimal_available_percentage" {
  description = "Set the minimal available storage percentage. **This values should be modified only when really needed.** The default is 25%, as https://longhorn.io/docs/1.3.1/best-practices/#minimal-available-storage-and-over-provisioning[recommended in the best practices] for single-disk nodes."
  type        = number
  default     = 25
}

variable "enable_pv_backups" {
  description = "Boolean to enable backups of Longhorn volumes to an external object storage."
  type        = bool
  default     = false
}

variable "set_default_storage_class" {
  description = "Boolean to set the Storage Class with the backup configuration as the default for all Persistent Volumes."
  type        = bool
  default     = true
}

variable "backup_storage" {
  description = "Exoscale SOS bucket configuration where the backups will be stored. **This configuration is required if the variable `enable_pv_backups` is set to `true`.**"
  type = object({
    bucket_name = string
    region      = string
    endpoint    = string
    access_key  = string
    secret_key  = string
  })
  default = null
}

variable "backup_configuration" {
  description = <<-EOT
    The following values can be configured:
    . `snapshot_cron` - Cron schedule to configure Longhorn automatic snapshots.
    . `snapshot_retention` - Retention of Longhorn automatic snapshots in days.
    . `backup_cron` - Cron schedule to configure Longhorn automatic backups.
    . `backup_retention` - Retention of Longhorn automatic backups in days.
  EOT

  type = object({
    snapshot_cron      = string
    snapshot_retention = number
    backup_cron        = string
    backup_retention   = number
  })

  default = {
    snapshot_cron      = "0 */2 * * *"
    snapshot_retention = "1"
    backup_cron        = "30 */12 * * *"
    backup_retention   = "2"
  }
}

variable "enable_service_monitor" {
  description = "Boolean to enable the deployment of a service monitor."
  type        = bool
  default     = false
}

variable "enable_dashboard_ingress" {
  description = "Boolean to enable the creation of an ingress for the Longhorn's dashboard. **If enabled, you must provide a value for `base_domain`.**"
  type        = bool
  default     = false
}

variable "enable_monitoring_dashboard" {
  description = "Boolean to enable the provisioning of a Longhorn dashboard for Grafana."
  type        = bool
  default     = true
}

variable "oidc" {
  description = "OIDC settings to configure OAuth2-Proxy which will be used to protect Longhorn's dashboard."
  type = object({
    issuer_url              = string
    oauth_url               = optional(string, "")
    token_url               = optional(string, "")
    api_url                 = optional(string, "")
    client_id               = string
    client_secret           = string
    oauth2_proxy_extra_args = optional(list(string), [])
  })
  default = null
}
