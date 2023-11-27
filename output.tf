output cognito_endpoint {
  value = format("https://%s.auth.ap-northeast-1.amazoncognito.com", aws_cognito_user_pool_domain.this.domain)
}

output cognito_redirect_endpoint {
  value = format("https://%s.auth.ap-northeast-1.amazoncognito.com/oauth2/idpresponse", aws_cognito_user_pool_domain.this.domain)
}
