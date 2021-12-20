module "spa_oauth_app" {
  source                     = "../../"
  type                       = "browser"
  environment                = "dev"
  name                       = "awesome_app"
  token_endpoint_auth_method = "none"
  grant_types                = ["authorization_code", "implicit"]
  redirect_uris              = ["https://localhost:8080/callback", "https://awesomeapp.com/callback"]
  post_logout_redirect_uris  = ["https://localhost:8080/callback/logout"]
  trusted_origins            = ["https://awesomeapp.com"]
  response_types             = ["code", "id_token", "token"]
  app_user_group_rule_groups = ["Everyone"]
  consent_method             = "REQUIRED"
  user_tags = {
    team    = "devops"
    purpose = "my okta app"
    owner   = "You"
  }
  octopus_tags = var.octopus_tags
}
