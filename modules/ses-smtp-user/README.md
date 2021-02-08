## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the IAM user | `string` | n/a | yes |
| path | Path in which to create the user | `string` | `null` | no |
| permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the user | `string` | `null` | no |
| user\_policy\_name\_prefix | Name prefix of the IAM policy that is assigned to the user | `string` | `"SESSendOnlyAccess"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the IAM user |
| login | IAM Access Key of the created user, used as the SMTP user name |
| name | IAM user name |
| password | The secret access key converted into an SES SMTP password |

