terraform {
  required_version = ">=1.0.0"
  required_providers {
    okta = {
      source  = "okta/okta"
      version = ">= 3.20"
    }
  }
}
