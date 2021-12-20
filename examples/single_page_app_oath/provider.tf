provider "okta" {
  org_name  = var.okta_provider_config.org_name
  base_url  = var.okta_provider_config.base_url
  api_token = var.okta_provider_config.api_token
}

provider "aws" {}