<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_user_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_callback_domain_base"></a> [callback\_domain\_base](#input\_callback\_domain\_base) | n/a | `any` | n/a | yes |
| <a name="input_google_client_id"></a> [google\_client\_id](#input\_google\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_google_client_secret"></a> [google\_client\_secret](#input\_google\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | n/a | `any` | n/a | yes |
| <a name="input_listener_rule_priority"></a> [listener\_rule\_priority](#input\_listener\_rule\_priority) | n/a | `number` | `1` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"cognite"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognito_endpoint"></a> [cognito\_endpoint](#output\_cognito\_endpoint) | n/a |
| <a name="output_cognito_redirect_endpoint"></a> [cognito\_redirect\_endpoint](#output\_cognito\_redirect\_endpoint) | n/a |
<!-- END_TF_DOCS -->