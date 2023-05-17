locals {
  hostname                 = format("longhorn.apps.%s", var.base_domain)
  hostname_withclustername = format("longhorn.apps.%s.%s", var.cluster_name, var.base_domain)
  helm_values = [{
    oidc = {
      issuer_url    = var.oidc.issuer_url
      redirect_url  = var.oidc.redirect_url
      client_id     = var.oidc.client_id
      client_secret = var.oidc.client_secret
      cookie_secret = var.oidc.cookie_secret != "" ? var.oidc.cookie_secret : random_string.cookie_secret.0.result
      oauth2_proxy_extra_args = var.cluster_issuer == "ca-issuer" || var.cluster_issuer == "letsencrypt-staging" ? [
        "--insecure-oidc-skip-issuer-verification=true",
        "--ssl-insecure-skip-verify=true",
      ] : []
    }
    ingress = {
      enabled = var.enable_dashboard_ingress
      hosts = [
        local.hostname,
        local.hostname_withclustername
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

resource "random_string" "cookie_secret" {
  count   = var.oidc.cookie_secret != "" ? 0 : 1
  length  = 24
  special = false
}
