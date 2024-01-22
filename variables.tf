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
  default     = "selfsigned-issuer"
}

variable "argocd_project" {
  description = "Name of the Argo CD AppProject where the Application should be created. If not set, the Application will be created in a new AppProject only for this Application."
  type        = string
  default     = null
}

variable "argocd_labels" {
  description = "Labels to attach to the Argo CD Application resource."
  type        = map(string)
  default     = {}
}

variable "destination_cluster" {
  description = "Destination cluster where the application should be deployed."
  type        = string
  default     = "in-cluster"
}

variable "target_revision" {
  description = "Override of target revision of the application chart."
  type        = string
  default     = "v3.1.0" # x-release-please-version
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
  description = "Set the storage over-provisioning percentage. **This values should be modified only when really needed.**"
  type        = number
  default     = 100
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
    . `snapshot_enabled` - Enable Longhorn automatic snapshots.
    . `snapshot_cron` - Cron schedule to configure Longhorn automatic snapshots.
    . `snapshot_retention` - Retention of Longhorn automatic snapshots in days.
    . `backup_enabled` - Enable Longhorn automatic backups to object storage.
    . `backup_cron` - Cron schedule to configure Longhorn automatic backups.
    . `backup_retention` - Retention of Longhorn automatic backups in days.

    /!\ These settings cannot be changed after StorageClass creation without having to recreate it!
  EOT

  type = object({
    snapshot_enabled   = bool
    snapshot_cron      = string
    snapshot_retention = number
    backup_enabled     = bool
    backup_cron        = string
    backup_retention   = number
  })

  default = {
    snapshot_enabled   = false
    snapshot_cron      = "0 */2 * * *"
    snapshot_retention = "1"
    backup_enabled     = false
    backup_cron        = "30 */12 * * *"
    backup_retention   = "2"
  }
}

variable "enable_preupgrade_check" {
  description = "Boolean to enable the pre-upgrade check. Usually this value should be set to `true` and only set to `false` if you are bootstrapping a new cluster, otherwise the first deployment will not work."
  type        = bool
  default     = true
}

variable "enable_service_monitor" {
  description = "Boolean to enable the deployment of a service monitor."
  type        = bool
  default     = false
}

variable "additional_alert_labels" {
  description = "Additional labels to add to Longhorn alerts."
  type        = map(string)
  default     = {}
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

variable "automatic_filesystem_trim" {
  description = "Settings to enable and configure automatic filesystem trim of volumes managed by Longhorn."
  type = object({
    enabled   = bool
    cron      = string
    job_group = string
  })
  default = {
    enabled   = false
    cron      = "0 6 * * *"
    job_group = ""
  }
}

variable "recurring_job_selectors" {
  description = "Define a group list to add to recurring job selector for the default storage class (the custom backup one if `set_default_storage_class` is set or else the Longhorn default one)."
  type = list(object({
    name    = string
    isGroup = bool
  }))
  default = null
}

variable "replica_count" {
  description = "Amount of replicas created by Longhorn for each volume."
  type        = number
  default     = 2
}

variable "tolerations" {
  description = <<-EOT
    Tolerations to be added to the core Longhorn components that manage storage on nodes. **These tolerations are required if you want Longhorn to schedule storage on nodes that are tainted.**

    These settings only have an effect on the first deployment. If added at a later time, you need to also add them on the _Settings_ tab in the Longhorn Dashboard. Check the https://longhorn.io/docs/latest/advanced-resources/deploy/taint-toleration/[official documentation] for more detailed information.

    **Only tolerations with the "Equal" operator are supported**, because the Longhorn Helm chart expects a parsed list as a string in the `defaultSettings.taintToleration` value.
  EOT
  type = list(object({
    key      = string
    operator = string
    value    = string
    effect   = string
  }))
  default = []
}
