## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.acm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns | n/a | `string` | n/a | yes |
| dns\_zone | n/a | `string` | n/a | yes |
| env | n/a | `string` | n/a | yes |
| forward\_query\_string | n/a | `bool` | `true` | no |
| geolocations | n/a | `list(string)` | `[]` | no |
| lambda\_arn | n/a | `string` | n/a | yes |
| name | n/a | `string` | n/a | yes |
| price\_class | n/a | `string` | `"PriceClass_100"` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
| internal\_endpoint | n/a |

