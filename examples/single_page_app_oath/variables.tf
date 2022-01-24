variable "okta_org_name" {
  description = "Okta org name to configure the Okta provider. Availble in Okta Variables Library Set."
  type        = string
}

variable "okta_base_url" {
  description = "Okta base url to configure the Okta provider. Availble in Okta Variables Library Set."
  type        = string
}

variable "okta_api_token" {
  description = "Okta api token to configure the Okta provider. Availble in Okta Variables Library Set."
  type        = string
}

variable "octopus_tags" {
  description = "Tags set by Octopus"
  type        = map(any)
}
