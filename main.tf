resource "okta_group" "admin" {
  name = "app-${var.environment}-${var.name}-administrators"
}

resource "okta_group" "users" {
  name = "app-${var.environment}-${var.name}-users"

}

resource "okta_group_role" "app_group_admin" {
  group_id          = okta_group.admin.id
  role_type         = "GROUP_MEMBERSHIP_ADMIN"
  target_group_list = [okta_group.users.id]
}

resource "okta_app_oauth" "app" {
  label                            = "${var.environment}-${var.name}"
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
  admin_note                       = var.admin_note
  enduser_note                     = var.enduser_note
  app_settings_json                = var.app_settings_json
  implicit_assignment              = var.implicit_assignment
  skip_users                       = var.skip_users
  skip_groups                      = var.skip_groups
  hide_ios                         = var.hide_ios
  hide_web                         = var.hide_web
  dynamic "groups_claim" {
    for_each = var.groups_claim
    content {
      type        = group_claims.values.type
      filter_type = group_claims.values.filter_type
      name        = group_claims.values.name
      value       = group_claims.values.value
    }
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

  dynamic "group" {
    for_each = var.custom_group_assignments
    content {
      id      = group.values.id
      profile = group.values.id.profile
    }
  }
}
