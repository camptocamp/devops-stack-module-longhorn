locals {
  domain              = format("longhorn.apps.%s", var.base_domain)
  domain_with_cluster = format("longhorn.apps.%s.%s", var.cluster_name, var.base_domain)

  helm_values = [{
    oidc = {
      issuer_url              = var.oidc.issuer_url
      redirect_url            = format("https://%s/oauth2/callback", local.hostname_withclustername)
      client_id               = var.oidc.client_id
      client_secret           = var.oidc.client_secret
      cookie_secret           = resource.random_string.oauth2_cookie_secret.result
      oauth2_proxy_extra_args = var.oidc.oauth2_proxy_extra_args
    } : null
    ingress = {
      enabled = var.enable_dashboard_ingress
      hosts = [
        local.domain,
        local.domain_with_cluster
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
    servicemonitor = {
      enabled = var.enable_service_monitor
    }
  }]
}

resource "random_string" "oauth2_cookie_secret" {
  length  = 32
  special = false
}
