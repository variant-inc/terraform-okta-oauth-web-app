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

output "client_secret" {
  description = "The client secret of the Okta application."
  value       = okta_app_oauth.app.client_secret
}

output "app_admin_group_name" {
  description = "Group name of the admin group for the Okta app."
  value       = "app-${var.environment}-${var.name}-administrators"
}

output "app_users_group_name" {
  description = "Group name of the admin group for the Okta app."
  value       = "app-${var.environment}-${var.name}-users"
}
