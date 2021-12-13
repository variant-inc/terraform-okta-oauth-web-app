variable "okta_provider_config" {
  description = "Okta org name url to configure the Okta provider"
  type = object({
    org_name  = string
    base_url  = string
    api_token = string
  })
  default = {
    org_name  = "org_name"
    base_url  = "oktapreview.com"
    api_token = "000000000000000000000000000"
  }
}
