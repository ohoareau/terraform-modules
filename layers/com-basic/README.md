## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns | n/a | `string` | n/a | yes |
| env | n/a | `string` | n/a | yes |
| identities | n/a | `map(string)` | `{}` | no |
| service\_sources | n/a | `list(string)` | `[]` | no |
| smtp\_user\_name | Name of the optional IAM User to create and for which to enable SES SMTP access | `string` | `null` | no |
| sources | n/a | `list(string)` | `[]` | no |
| zone | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| identities | n/a |
| smtp\_user | Optional SES SMTP user credentials |

