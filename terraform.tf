terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = ">= 5"
    }
    utils = {
      source  = "cloudposse/utils"
      version = ">= 1"
    }
    random = {
      source  = "random"
      version = ">= 3"
    }
  }
}
