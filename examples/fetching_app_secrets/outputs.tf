output "client_data" {
  description = "Example on referencing client data from"
  sensitive   = true
  value       = data.aws_secretsmanager_secret_version.app_client_data.secret_string
}