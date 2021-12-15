variable "name" {
  description = "Name of application using the Okta app."
  type        = string
}

variable "environment" {
  description = "Environment of Okta app."
  type        = string
}

variable "user_tags" {
  description = "User tags. See module docs in README.md"
  type        = map(string)
}

variable "octopus_tags" {
  description = "Octopus Tags. See module docs in README.md"
  type        = map(string)
}

variable "type" {
  description = "The type of OAuth application. Valid values: \"web\", \"native\", \"browser\", \"service\"."
  validation {
    condition     = contains(["web", "native", "browser", "service"], var.type)
    error_message = "Supported values are [\"web\", \"native\", \"browser\", \"service\"]."
  }
  type    = string
  default = "browser"
}

variable "status" {
  description = "The status of the application."
  type        = string
  default     = "ACTIVE"
}

variable "token_endpoint_auth_method" {
  description = "Requested authentication method for the token endpoint. It can be set to \"none\", \"client_secret_post\", \"client_secret_basic\", \"client_secret_jwt\", \"private_key_jwt\". To enable PKCE, set this to \"none\"."
  validation {
    condition     = contains(["none", "client_secret_post", "client_secret_basic", "client_secret_jwt", "private_key_jwt"], var.token_endpoint_auth_method)
    error_message = "Supported values are [\"none\", \"client_secret_post\", \"client_secret_basic\", \"client_secret_jwt\", \"private_key_jwt\"]."
  }
  type    = string
  default = "none"
}

variable "auto_key_rotation" {
  description = "Requested key rotation mode"
  type        = bool
  default     = true
}

variable "client_uri" {
  description = "URI to a web page providing information about the client."
  type        = string
  default     = null
}

variable "login_mode" {
  description = "The type of Idp-Initiated login that the client supports, if any. Valid values: \"DISABLED\", \"SPEC\", \"OKTA\""
  validation {
    condition     = contains(["DISABLED", "SPEC", "OKTA"], var.login_mode)
    error_message = "Supported values are [\"DISABLED\", \"SPEC\", \"OKTA\"]."
  }
  type    = string
  default = "DISABLED"
}

variable "login_scopes" {
  description = "List of scopes to use for the request. Valid values: \"openid\", \"profile\", \"email\", \"address\", \"phone\". Required when login_mode is NOT DISABLED."
  type        = list(string)
  default     = null
}
variable "login_uri" {
  description = "URI that initiates login. Required when login_mode is NOT DISABLED."
  type        = string
  default     = null
}

variable "redirect_uris" {
  description = "Login redirect URIs."
  type        = list(string)
  default     = null
}

variable "wildcard_redirect" {
  description = "Early Access Property. Indicates if the client is allowed to use wildcard matching of redirect_uris. Valid values: \"DISABLED\", \"SUBDOMAIN\"."
  type        = string
  default     = "DISABLED"
}

variable "post_logout_redirect_uris" {
  description = "Logout redirect URIs."
  type        = list(string)
  default     = null
}

variable "response_types" {
  description = "List of OAuth 2.0 response type strings."
  type        = list(string)
  default     = null
}

variable "grant_types" {
  description = "List of OAuth 2.0 grant type strings. Conditional validation params found [here](https://developer.okta.com/docs/api/resources/apps#credentials-settings-details). Defaults to minimum requirements per app type. Valid values: \"authorization_code\", \"implicit\", \"password\", \"refresh_token\", \"client_credentials\", \"urn:ietf:params:oauth:grant-type:saml2-bearer\" (Early Access Property), \"urn:ietf:params:oauth:grant-type:token-exchange\" (Early Access Property)"
  type        = list(string)
}

variable "tos_uri" {
  description = "URI to web page providing client tos (terms of service)."
  type        = string
  default     = null
}

variable "policy_uri" {
  description = "URI to web page providing client policy document."
  type        = string
  default     = null
}

variable "consent_method" {
  description = "Indicates whether user consent is required or implicit. Valid values: \"REQUIRED\", \"TRUSTED\""
  type        = string
  default     = "REQUIRED"
  validation {
    condition     = contains(["REQUIRED", "TRUSTED"], var.consent_method)
    error_message = "Supported values are [\"REQUIRED\", \"TRUSTED\"]."
  }
}

variable "issuer_mode" {
  description = "Indicates whether the Okta Authorization Server uses the original Okta org domain URL or a custom domain URL as the issuer of ID token for this client."
  type        = string
  default     = "ORG_URL"
}

variable "refresh_token_rotation" {
  description = "Refresh token rotation behavior. Valid values: \"STATIC\" or \"ROTATE\"."
  type        = string
  default     = null
}

variable "refresh_token_leeway" {
  description = "Grace period for token rotation. Valid values: 0 to 60 seconds."
  type        = string
  default     = null
}

variable "accessibility_error_redirect_url" {
  description = "Custom error page URL."
  type        = string
  default     = null
}

variable "accessibility_login_redirect_url" {
  description = "Custom login page for this application."
  type        = string
  default     = null
}


variable "accessibility_self_service" {
  description = "Enable self-service."
  type        = bool
  default     = false
}

variable "user_name_options" {
  description = "Username template. |  Username template suffix. | Username template type. | Push username on update."
  type = object({
    user_name_template             = string
    user_name_template_suffix      = string
    user_name_template_type        = string
    user_name_template_push_status = string
  })
  default = {
    user_name_template             = "${"$"}{source.login}"
    user_name_template_suffix      = ""
    user_name_template_type        = "BUILT_IN"
    user_name_template_push_status = ""
  }

}

variable "profile" {
  description = "Custom JSON that represents an OAuth application's profile."
  type        = string
  default     = "{}"
}

variable "implicit_assignment" {
  description = "Early Access Property. Enables [Federation Broker Mode](https://help.okta.com/en/prod/Content/Topics/Apps/apps-fbm-enable.htm). When this mode is enabled, users and groups arguments are ignored."
  type        = bool
  default     = false
}

variable "hide_ios" {
  description = "Do not display application icon on mobile app."
  type        = bool
  default     = true
}

variable "hide_web" {
  description = "Do not display application icon to users."
  type        = bool
  default     = true
}

variable "logo" {
  description = "Local file path to the logo. The file must be in PNG, JPG, or GIF format, and less than 1 MB in size."
  type        = string
  default     = null
}

variable "groups_claim" {
  description = "Groups claim for an OpenID Connect client application."
  type = list(object({
    type        = string
    filter_type = string
    name        = string
    value       = string
  }))
  default = []
}

variable "enduser_note" {
  description = "Application notes for end users."
  type        = string
  default     = null
}

variable "app_settings_json" {
  description = "Application settings in JSON format"
  type        = string
  default     = "{}"
}

variable "skip_users" {
  description = "Indicator that allows the app to skip users sync (it's also can be provided during import)"
  type        = bool
  default     = false
}

variable "skip_groups" {
  description = "Indicator that allows the app to skip groups sync (it's also can be provided during import)"
  type        = bool
  default     = false
}

variable "trusted_origins" {
  description = "Urls to add as trusted origins to Okta Security"
  type        = list(string)
  default     = []
}

variable "app_user_group_rule_groups" {
  description = "Okta group names. Users of these groups will be added to your Okta app's user group"
  type        = list(string)
  default     = null
}
