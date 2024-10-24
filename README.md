<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.3, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.44.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.cookielab_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cookielab_console](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cookielab_api_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cookielab_api_ro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cookielab_console_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cookielab_console_ro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.cookielab_assume_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cookielab_assume_console](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator"></a> [administrator](#input\_administrator) | ReadOnly or Administrator Access | `bool` | `false` | no |
| <a name="input_assume_from_sso"></a> [assume\_from\_sso](#input\_assume\_from\_sso) | List of objects containing `aws_source_account_id`, `sso_region` and `sso_permissions_set_name` to be allowed to assume console role | <pre>list(object({<br/>    aws_source_account_id    = string<br/>    sso_region               = string<br/>    sso_permissions_set_name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_destination_role_name_api"></a> [destination\_role\_name\_api](#input\_destination\_role\_name\_api) | Role name for API access in destination AWS account | `string` | `null` | no |
| <a name="input_destination_role_name_console"></a> [destination\_role\_name\_console](#input\_destination\_role\_name\_console) | Role name for Console access in destination AWS account | `string` | `null` | no |
| <a name="input_destination_role_name_prefix"></a> [destination\_role\_name\_prefix](#input\_destination\_role\_name\_prefix) | Prefix for role names in destination AWS account | `string` | `"zzzzz-"` | no |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | External ID for link verification | `string` | n/a | yes |
| <a name="input_source_role_arn"></a> [source\_role\_arn](#input\_source\_role\_arn) | Role ARN in source AWS account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_role_arn"></a> [api\_role\_arn](#output\_api\_role\_arn) | n/a |
| <a name="output_api_role_name"></a> [api\_role\_name](#output\_api\_role\_name) | n/a |
| <a name="output_console_role_arn"></a> [console\_role\_arn](#output\_console\_role\_arn) | n/a |
| <a name="output_console_role_name"></a> [console\_role\_name](#output\_console\_role\_name) | n/a |
<!-- END_TF_DOCS -->