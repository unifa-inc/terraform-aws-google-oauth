locals {
  callback_urls = [format("https://%s/oauth2/idpresponse", var.callback_domain_base)]
}

resource aws_cognito_user_pool this {
  name                     = format("%s-google-oauth-pool", var.prefix)
  auto_verified_attributes = ["email"]
}

resource aws_cognito_user_pool_domain this {
  domain       = format("%s-google-oauth", var.prefix)
  user_pool_id = aws_cognito_user_pool.this.id
}

resource aws_cognito_identity_provider this {
  user_pool_id  = aws_cognito_user_pool.this.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email"
    client_id        = var.google_client_id
    client_secret    = var.google_client_secret
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
      values = ["*"]
    }
  }
}
