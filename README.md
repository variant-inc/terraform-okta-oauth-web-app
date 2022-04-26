# Okta OAUTH App Module

## [Examples](examples)
### [SPA](examples/single_page_app_oauth)
### [Using Secrets pushed to ASM](examples/fetching_app_secrets)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_okta"></a> [okta](#provider\_okta) | >= 3.20 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | github.com/variant-inc/lazy-terraform//submodules/tags | v1 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.app_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.app_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [okta_app_group_assignments.app_groups_assignments](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignments) | resource |
| [okta_app_oauth.app](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth) | resource |
| [okta_auth_server_claim.admin_identity_claim](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_claim) | resource |
| [okta_auth_server_claim.admin_resource_claim](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_claim) | resource |
| [okta_group.admin](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group) | resource |
| [okta_group.users](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group) | resource |
| [okta_group_role.app_group_admin](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_role) | resource |
| [okta_group_rule.app_user_group_rule](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_rule) | resource |
| [okta_trusted_origin.app_trusted_origins](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/trusted_origin) | resource |
| [okta_auth_server.default_auth_server](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/auth_server) | data source |
| [okta_group.app_user_group_rule_groups](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accessibility_error_redirect_url"></a> [accessibility\_error\_redirect\_url](#input\_accessibility\_error\_redirect\_url) | Custom error page URL. | `string` | `null` | no |
| <a name="input_accessibility_login_redirect_url"></a> [accessibility\_login\_redirect\_url](#input\_accessibility\_login\_redirect\_url) | Custom login page for this application. | `string` | `null` | no |
| <a name="input_accessibility_self_service"></a> [accessibility\_self\_service](#input\_accessibility\_self\_service) | Enable self-service. | `bool` | `false` | no |
| <a name="input_app_settings_json"></a> [app\_settings\_json](#input\_app\_settings\_json) | Application settings in JSON format | `string` | `"{}"` | no |
| <a name="input_app_user_group_rule_groups"></a> [app\_user\_group\_rule\_groups](#input\_app\_user\_group\_rule\_groups) | Okta group names. Users of these groups will be added to your Okta app's user group | `list(string)` | `null` | no |
| <a name="input_auto_key_rotation"></a> [auto\_key\_rotation](#input\_auto\_key\_rotation) | Requested key rotation mode | `bool` | `true` | no |
| <a name="input_client_uri"></a> [client\_uri](#input\_client\_uri) | URI to a web page providing information about the client. | `string` | `null` | no |
| <a name="input_consent_method"></a> [consent\_method](#input\_consent\_method) | Indicates whether user consent is required or implicit. Valid values: "REQUIRED", "TRUSTED" | `string` | `"REQUIRED"` | no |
| <a name="input_enduser_note"></a> [enduser\_note](#input\_enduser\_note) | Application notes for end users. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment of Okta app. | `string` | n/a | yes |
| <a name="input_grant_types"></a> [grant\_types](#input\_grant\_types) | List of OAuth 2.0 grant type strings. Conditional validation params found [here](https://developer.okta.com/docs/api/resources/apps#credentials-settings-details). Defaults to minimum requirements per app type. Valid values: "authorization\_code", "implicit", "password", "refresh\_token", "client\_credentials", "urn:ietf:params:oauth:grant-type:saml2-bearer" (Early Access Property), "urn:ietf:params:oauth:grant-type:token-exchange" (Early Access Property) | `list(string)` | n/a | yes |
| <a name="input_hide_ios"></a> [hide\_ios](#input\_hide\_ios) | Do not display application icon on mobile app. | `bool` | `true` | no |
| <a name="input_hide_web"></a> [hide\_web](#input\_hide\_web) | Do not display application icon to users. | `bool` | `true` | no |
| <a name="input_implicit_assignment"></a> [implicit\_assignment](#input\_implicit\_assignment) | Early Access Property. Enables [Federation Broker Mode](https://help.okta.com/en/prod/Content/Topics/Apps/apps-fbm-enable.htm). When this mode is enabled, users and groups arguments are ignored. | `bool` | `false` | no |
| <a name="input_issuer_mode"></a> [issuer\_mode](#input\_issuer\_mode) | Indicates whether the Okta Authorization Server uses the original Okta org domain URL or a custom domain URL as the issuer of ID token for this client. | `string` | `"ORG_URL"` | no |
| <a name="input_login_mode"></a> [login\_mode](#input\_login\_mode) | The type of Idp-Initiated login that the client supports, if any. Valid values: "DISABLED", "SPEC", "OKTA" | `string` | `"DISABLED"` | no |
| <a name="input_login_scopes"></a> [login\_scopes](#input\_login\_scopes) | List of scopes to use for the request. Valid values: "openid", "profile", "email", "address", "phone". Required when login\_mode is NOT DISABLED. | `list(string)` | `null` | no |
| <a name="input_login_uri"></a> [login\_uri](#input\_login\_uri) | URI that initiates login. Required when login\_mode is NOT DISABLED. | `string` | `null` | no |
| <a name="input_logo"></a> [logo](#input\_logo) | Local file path to the logo. The file must be in PNG, JPG, or GIF format, and less than 1 MB in size. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of application using the Okta app. | `string` | n/a | yes |
| <a name="input_octopus_tags"></a> [octopus\_tags](#input\_octopus\_tags) | Octopus Tags. See module docs in README.md | `map(string)` | n/a | yes |
| <a name="input_policy_uri"></a> [policy\_uri](#input\_policy\_uri) | URI to web page providing client policy document. | `string` | `null` | no |
| <a name="input_post_logout_redirect_uris"></a> [post\_logout\_redirect\_uris](#input\_post\_logout\_redirect\_uris) | Logout redirect URIs. | `list(string)` | `null` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Custom JSON that represents an OAuth application's profile. | `string` | `"{}"` | no |
| <a name="input_redirect_uris"></a> [redirect\_uris](#input\_redirect\_uris) | Login redirect URIs. | `list(string)` | `null` | no |
| <a name="input_refresh_token_leeway"></a> [refresh\_token\_leeway](#input\_refresh\_token\_leeway) | Grace period for token rotation. Valid values: 0 to 60 seconds. | `string` | `null` | no |
| <a name="input_refresh_token_rotation"></a> [refresh\_token\_rotation](#input\_refresh\_token\_rotation) | Refresh token rotation behavior. Valid values: "STATIC" or "ROTATE". | `string` | `null` | no |
| <a name="input_response_types"></a> [response\_types](#input\_response\_types) | List of OAuth 2.0 response type strings. | `list(string)` | `null` | no |
| <a name="input_skip_groups"></a> [skip\_groups](#input\_skip\_groups) | Indicator that allows the app to skip groups sync (it's also can be provided during import) | `bool` | `false` | no |
| <a name="input_skip_users"></a> [skip\_users](#input\_skip\_users) | Indicator that allows the app to skip users sync (it's also can be provided during import) | `bool` | `false` | no |
| <a name="input_status"></a> [status](#input\_status) | The status of the application. | `string` | `"ACTIVE"` | no |
| <a name="input_token_endpoint_auth_method"></a> [token\_endpoint\_auth\_method](#input\_token\_endpoint\_auth\_method) | Requested authentication method for the token endpoint. It can be set to "none", "client\_secret\_post", "client\_secret\_basic", "client\_secret\_jwt", "private\_key\_jwt". To enable PKCE, set this to "none". | `string` | `"none"` | no |
| <a name="input_tos_uri"></a> [tos\_uri](#input\_tos\_uri) | URI to web page providing client tos (terms of service). | `string` | `null` | no |
| <a name="input_trusted_origins"></a> [trusted\_origins](#input\_trusted\_origins) | Urls to add as trusted origins to Okta Security | `list(string)` | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of OAuth application. Valid values: "web", "native", "browser", "service". | `string` | `"browser"` | no |
| <a name="input_user_name_options"></a> [user\_name\_options](#input\_user\_name\_options) | Username template. \|  Username template suffix. \| Username template type. \| Push username on update. | <pre>object({<br>    user_name_template             = string<br>    user_name_template_suffix      = string<br>    user_name_template_type        = string<br>    user_name_template_push_status = string<br>  })</pre> | <pre>{<br>  "user_name_template": "${source.login}",<br>  "user_name_template_push_status": "",<br>  "user_name_template_suffix": "",<br>  "user_name_template_type": "BUILT_IN"<br>}</pre> | no |
| <a name="input_user_tags"></a> [user\_tags](#input\_user\_tags) | User tags. See module docs in README.md | `map(string)` | n/a | yes |
| <a name="input_wildcard_redirect"></a> [wildcard\_redirect](#input\_wildcard\_redirect) | Early Access Property. Indicates if the client is allowed to use wildcard matching of redirect\_uris. Valid values: "DISABLED", "SUBDOMAIN". | `string` | `"DISABLED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app"></a> [app](#output\_app) | Okta App details |
| <a name="output_app_admin_group_name"></a> [app\_admin\_group\_name](#output\_app\_admin\_group\_name) | Group name of the admin group for the Okta app. |
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | Okta App Id. |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | Okta App display name. |
| <a name="output_app_secrets_arn"></a> [app\_secrets\_arn](#output\_app\_secrets\_arn) | The Amazon Secret Manager ARN of the Okta app's secrets. |
| <a name="output_app_secrets_name"></a> [app\_secrets\_name](#output\_app\_secrets\_name) | The Amazon Secret Manager name of the Okta app's secrets. |
| <a name="output_app_users_group_name"></a> [app\_users\_group\_name](#output\_app\_users\_group\_name) | Group name of the admin group for the Okta app. |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The client ID of the Okta application. |
<!-- END_TF_DOCS -->