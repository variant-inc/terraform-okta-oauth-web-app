module "spa_oauth_app" {
  source = "../../"
  okta_provider_config = {
    "org_name" : "awesome-org",
    "base_url" : "oktapreview.com",
    "api_token" : "0000000000000000000"

  }
  type                      = "browser"
  environment               = "dev"
  name                      = "awesome_app"
  grant_types               = ["authorization_code", "implicit"]
  redirect_uris             = ["https://localhost:8080/callback"]
  post_logout_redirect_uris = ["https://localhost:8080/callback/logout"]
  response_types            = ["code", "id_token", "token"]
  admin_note                = "Test application in dev environment managed by cloudops team."
}
