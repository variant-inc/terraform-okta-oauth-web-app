data "okta_group" "app_user_group_rule_groups" {
  count = length(var.app_user_group_rule_groups)
  name  = var.app_user_group_rule_groups[count.index]
}

locals {
  kebab_name = "${var.environment}-${var.name}"
  group_rule_group_list = join(",",
    formatlist("\"%s\"", data.okta_group.app_user_group_rule_groups.*.id)
  )
  group_rule_expression_value = "isMemberOfAnyGroup(${local.group_rule_group_list})"
}

module "tags" {
  source       = "github.com/variant-inc/lazy-terraform//submodules/tags?ref=v1"
  name         = var.name
  user_tags    = var.user_tags
  octopus_tags = var.octopus_tags
}

resource "okta_group" "admin" {
  name = "app-${local.kebab_name}-administrators"
}

resource "okta_group" "users" {
  name = "app-${local.kebab_name}-users"
}

resource "okta_group_role" "app_group_admin" {
  group_id          = okta_group.admin.id
  role_type         = "GROUP_MEMBERSHIP_ADMIN"
  target_group_list = [okta_group.users.id]
}

resource "okta_group_rule" "app_user_group_rule" {
  count  = data.okta_group.app_user_group_rule_groups == null ? 0 : 1
  name   = "app-${local.kebab_name} User Group Rule"
  status = "ACTIVE"
  group_assignments = [
    okta_group.users.id
  ]
  remove_assigned_users = true
  expression_type       = "urn:okta:expression:1.0"
  expression_value      = local.group_rule_expression_value
}

resource "okta_app_oauth" "app" {
  label                            = local.kebab_name
  type                             = var.type
  status                           = var.status
  token_endpoint_auth_method       = var.token_endpoint_auth_method
  auto_key_rotation                = var.auto_key_rotation
  client_uri                       = var.client_uri
  login_mode                       = var.login_mode
  login_scopes                     = var.login_scopes
  login_uri                        = var.login_uri
  redirect_uris                    = var.redirect_uris
  wildcard_redirect                = var.wildcard_redirect
  post_logout_redirect_uris        = var.post_logout_redirect_uris
  response_types                   = var.response_types
  grant_types                      = var.grant_types
  tos_uri                          = var.tos_uri
  policy_uri                       = var.policy_uri
  consent_method                   = var.consent_method
  issuer_mode                      = var.issuer_mode
  refresh_token_rotation           = var.refresh_token_rotation
  refresh_token_leeway             = var.refresh_token_leeway
  accessibility_error_redirect_url = var.accessibility_error_redirect_url
  accessibility_login_redirect_url = var.accessibility_login_redirect_url
  accessibility_self_service       = var.accessibility_self_service
  user_name_template               = var.user_name_options["user_name_template"]
  user_name_template_suffix        = var.user_name_options["user_name_template_suffix"]
  user_name_template_type          = var.user_name_options["user_name_template_type"]
  user_name_template_push_status   = var.user_name_options["user_name_template_push_status"]
  profile                          = var.profile
  logo                             = var.logo
  admin_note                       = "${module.tags.tags["Name"]}. ${module.tags.tags["owner"]}. ${module.tags.tags["team"]}. ${module.tags.tags["purpose"]}"
  enduser_note                     = var.enduser_note
  app_settings_json                = var.app_settings_json
  implicit_assignment              = var.implicit_assignment
  skip_users                       = var.skip_users
  skip_groups                      = var.skip_groups
  hide_ios                         = var.hide_ios
  hide_web                         = var.hide_web
  lifecycle {
    ignore_changes = [groups]
  }
}

resource "okta_app_group_assignments" "app_groups_assignments" {
  app_id = okta_app_oauth.app.id
  group {
    id       = okta_group.admin.id
    priority = 1
  }
  group {
    id       = okta_group.users.id
    priority = 2
  }
}

resource "aws_secretsmanager_secret" "app_secrets" {
  name = "okta-app-${local.kebab_name}"
  tags = module.tags.tags
}

resource "aws_secretsmanager_secret_version" "app_secret_version" {
  secret_id = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode({
    "client_id" : okta_app_oauth.app.client_id,
    "client_secret" : okta_app_oauth.app.client_secret
  })
}

resource "okta_trusted_origin" "app_trusted_origins" {
  for_each = toset(var.trusted_origins)
  name     = "Redirect for App ${local.kebab_name}: ${each.value}"
  origin   = each.value
  scopes   = ["CORS", "REDIRECT"]
}
