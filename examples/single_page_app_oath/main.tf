module "spa_oauth_app" {
  source                    = "../../"
  type                      = "browser"
  environment               = "dev"
  name                      = "awesome_app"
  grant_types               = ["authorization_code", "implicit"]
  redirect_uris             = ["https://localhost:8080/callback"]
  post_logout_redirect_uris = ["https://localhost:8080/callback/logout"]
  response_types            = ["code", "id_token", "token"]
  admin_note                = "Test application in dev environment managed by cloudops team."
}
