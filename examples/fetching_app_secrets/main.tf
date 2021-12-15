data "aws_secretsmanager_secret" "app_client_secret" {
  # Taken from output of this module
  name = "okta-app-awesome-app"
}

data "aws_secretsmanager_secret_version" "app_client_data" {
  secret_id = data.aws_secretsmanager_secret.app_client_secret.id
}

