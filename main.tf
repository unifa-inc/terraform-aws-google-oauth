locals {
  callback_urls = [format("https://%s/oauth2/idpresponse", var.callback_domain_base)]
}

resource aws_cognito_user_pool this {
  name                     = format("%s-google-oauth-pool", var.prefix)
  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
  
  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

resource aws_cognito_user_pool_domain this {
  domain       = format("%s-google-oauth", var.prefix)
  user_pool_id = aws_cognito_user_pool.this.id
}

resource aws_cognito_identity_provider this {
  user_pool_id  = aws_cognito_user_pool.this.id
  provider_name = "Google"
  provider_type = "Google"
  idp_identifiers = []

  provider_details = {
    authorize_scopes = "profile email openid"
    client_id        = var.google_client_id
    client_secret    = var.google_client_secret
    attributes_url                = "https://people.googleapis.com/v1/people/me?personFields="
    attributes_url_add_attributes = "true"
    authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
    oidc_issuer                   = "https://accounts.google.com"
    token_request_method          = "POST"
    token_url                     = "https://www.googleapis.com/oauth2/v4/token"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

resource aws_cognito_user_pool_client client {
  name = aws_cognito_identity_provider.this.user_pool_id

  user_pool_id = aws_cognito_identity_provider.this.user_pool_id

  callback_urls = local.callback_urls

  allowed_oauth_flows  = ["code", "implicit"]
  allowed_oauth_scopes = ["email", "openid", "profile"]

  supported_identity_providers = ["Google"]

  generate_secret = true
}

resource aws_lb_listener_rule this {
  listener_arn = var.listener_arn
  priority     = var.listener_rule_priority

  action {
    type = "authenticate-cognito"

    authenticate_cognito {
      user_pool_arn       = aws_cognito_user_pool.this.arn
      user_pool_client_id = aws_cognito_user_pool_client.client.id
      user_pool_domain    = aws_cognito_user_pool_domain.this.domain
    }
  }

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  lifecycle {
    ignore_changes = [
      action
    ]
  }
}
