locals {
  domain      = format("longhorn.apps.%s", var.base_domain)
  domain_full = format("longhorn.apps.%s.%s", var.cluster_name, var.base_domain)

  # Generate a list of tolerations in a string format of `key=value:effect` for all the tolerations that have 
  # an `operator` equal to `Equal`. This list of strings will be joined to pass as the value of 
  # `defaultSettings.taintToleration`.
  tolerations_list = [for toleration in var.tolerations : "${toleration.key}=${toleration.value}:${toleration.effect}" if toleration.operator == "Equal"]

  helm_values = [{
    longhorn = {
      defaultSettings = {
        backupTarget                      = var.enable_pv_backups ? format("s3://%s@%s/", var.backup_storage.bucket_name, var.backup_storage.region) : ""
        backupTargetCredentialSecret      = var.enable_pv_backups ? "longhorn-s3-secret" : ""
        defaultLonghornStaticStorageClass = var.enable_pv_backups && var.set_default_storage_class ? "longhorn-backup" : "longhorn-static"
        storageOverProvisioningPercentage = var.storage_over_provisioning_percentage
        storageMinimalAvailablePercentage = var.storage_minimal_available_percentage
        taintToleration                   = join(";", local.tolerations_list)
      }
      persistence = {
        defaultClass             = var.enable_pv_backups && var.set_default_storage_class ? "false" : "true"
        defaultClassReplicaCount = var.replica_count
      }
      longhornManager = {
        tolerations = var.tolerations
      }
    }
    backups = merge({
      enabled = var.enable_pv_backups
      }, var.enable_pv_backups ? {
      defaultStorageClass = var.set_default_storage_class
      config              = var.backup_configuration
      storage             = var.backup_storage
    } : null)
    numberOfReplicas = var.replica_count
    oidc = var.oidc != null ? {
      oauth2_proxy_image      = "quay.io/oauth2-proxy/oauth2-proxy:v7.4.0"
      issuer_url              = var.oidc.issuer_url
      redirect_url            = format("https://%s/oauth2/callback", local.domain_full)
      client_id               = var.oidc.client_id
      client_secret           = var.oidc.client_secret
      cookie_secret           = resource.random_string.oauth2_cookie_secret.result
      oauth2_proxy_extra_args = var.oidc.oauth2_proxy_extra_args
    } : null
    ingress = {
      enabled = var.enable_dashboard_ingress
      hosts = [
        local.domain,
        local.domain_full
      ]
      annotations = {
        "cert-manager.io/cluster-issuer"                   = "${var.cluster_issuer}"
        "traefik.ingress.kubernetes.io/router.entrypoints" = "websecure"
        "traefik.ingress.kubernetes.io/router.middlewares" = "traefik-withclustername@kubernetescrd"
        "traefik.ingress.kubernetes.io/router.tls"         = "true"
        "ingress.kubernetes.io/ssl-redirect"               = "true"
        "kubernetes.io/ingress.allow-http"                 = "false"
      }
    }
    grafana_dashboard = {
      enabled = var.enable_monitoring_dashboard
    }
    servicemonitor = {
      enabled = var.enable_service_monitor
    }
  }]
}

resource "random_string" "oauth2_cookie_secret" {
  length  = 32
  special = false
}
