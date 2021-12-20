variable "okta_provider_config" {
  description = "Okta org name url to configure the Okta provider. Set by Octopus."
  type = object({
    org_name  = string
    base_url  = string
    api_token = string
  })
  default = {
    org_name  = "aweson-org"
    base_url  = "oktapreview.com"
    api_token = "0000000000000000000000000000000000"
  }
}

variable "octopus_tags" {
  description = "Tags set by Octopus"
  type        = map(any)
}
