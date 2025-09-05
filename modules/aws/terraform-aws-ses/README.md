## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_route53_record.amazonses_dkim_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.amazonses_verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.spf_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret_val](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_ses_domain_dkim.ses_domain_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.ses_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_iam_policy_document.allow_iam_name_to_send_emails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_domain"></a> [create\_domain](#input\_create\_domain) | If provided the module will create a SES domain. | `bool` | `true` | no |
| <a name="input_create_secret"></a> [create\_secret](#input\_create\_secret) | If false, this module does nothing (since tf doesn't support conditional modules) | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description to add to Secret | `string` | `""` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to create the SES identity for. | `string` | n/a | yes |
| <a name="input_enable_spf_domain"></a> [enable\_spf\_domain](#input\_enable\_spf\_domain) | If provided the module will create Route53 DNS records used for SPF. | `bool` | `false` | no |
| <a name="input_iam_name"></a> [iam\_name](#input\_iam\_name) | IAM username. | `string` | `""` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Optional. The KMS Key ID to encrypt the secret. KMS key arn or alias can be used. | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name (omit to use name\_prefix) | `string` | `""` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name Prefix (not used if name specified) | `string` | `"terraform"` | no |
| <a name="input_pass_version"></a> [pass\_version](#input\_pass\_version) | Password version. Increment this to trigger a new password. | `number` | `1` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that AWS Secrets Manager waits before it can delete the secret. | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to supported resources | `map(string)` | `{}` | no |
| <a name="input_verify_dkim"></a> [verify\_dkim](#input\_verify\_dkim) | If provided the module will create Route53 DNS records used for DKIM verification. | `bool` | `false` | no |
| <a name="input_verify_domain"></a> [verify\_domain](#input\_verify\_domain) | If provided the module will create Route53 DNS records used for domain verification. | `bool` | `false` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 parent zone ID. If provided (not empty), the module will create Route53 DNS records used for verification | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | The SMTP user which is access key ID. |
| <a name="output_secret_access_key"></a> [secret\_access\_key](#output\_secret\_access\_key) | The IAM secret for usage with SES API. This will be written to the state file in plain text. |
| <a name="output_ses_dkim_tokens"></a> [ses\_dkim\_tokens](#output\_ses\_dkim\_tokens) | A list of DKIM Tokens which, when added to the DNS Domain as CNAME records, allows for receivers to verify that emails were indeed authorized by the domain owner. |
| <a name="output_ses_domain_identity_arn"></a> [ses\_domain\_identity\_arn](#output\_ses\_domain\_identity\_arn) | The ARN of the SES domain identity |
| <a name="output_ses_domain_identity_verification_token"></a> [ses\_domain\_identity\_verification\_token](#output\_ses\_domain\_identity\_verification\_token) | A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. The domain identity will be in state 'verification pending' until this is done. See below for an example of how this might be achieved when the domain is hosted in Route 53 and managed by Terraform. Find out more about verifying domains in Amazon SES in the AWS SES docs. |
| <a name="output_ses_smtp_password"></a> [ses\_smtp\_password](#output\_ses\_smtp\_password) | The SMTP password. This will be written to the state file in plain text. |
| <a name="output_user_arn"></a> [user\_arn](#output\_user\_arn) | The ARN assigned by AWS for this user. |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | Normalized IAM user name. |
| <a name="output_user_unique_id"></a> [user\_unique\_id](#output\_user\_unique\_id) | The unique ID assigned by AWS. |
