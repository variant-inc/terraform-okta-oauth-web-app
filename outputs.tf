output "app" {
  description = "Okta App details"
  value       = okta_app_oauth.app
}

output "app_name" {
  description = "Okta App display name."
  value       = okta_app_oauth.app.name
}

output "app_id" {
  description = "Okta App Id."
  value       = okta_app_oauth.app.id
}

output "client_id" {
  description = "The client ID of the Okta application."
  value       = okta_app_oauth.app.client_id
}

output "app_admin_group_name" {
  description = "Group name of the admin group for the Okta app."
  value       = "app-${var.environment}-${var.name}-administrators"
}

output "app_users_group_name" {
  description = "Group name of the admin group for the Okta app."
  value       = "app-${var.environment}-${var.name}-users"
}

output "app_secrets_arn" {
  description = "The Amazon Secret Manager ARN of the Okta app's secrets."
  value       = aws_secretsmanager_secret_version.app_secret_version.arn
}

output "app_secrets_name" {
  description = "The Amazon Secret Manager name of the Okta app's secrets."
  value       = "okta-app-${var.name}"
}
