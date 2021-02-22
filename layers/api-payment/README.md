## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_file | n/a | `string` | `""` | no |
| config\_statics\_file | n/a | `string` | `""` | no |
| dns | n/a | `string` | n/a | yes |
| dns\_zone | n/a | `string` | n/a | yes |
| env | n/a | `string` | n/a | yes |
| forward\_query\_string | n/a | `bool` | `null` | no |
| geolocations | n/a | `list(string)` | `[]` | no |
| handler | n/a | `string` | `"index.handler"` | no |
| healthz\_file | n/a | `string` | `""` | no |
| memory\_size | n/a | `number` | `512` | no |
| policy\_statements | n/a | <pre>list(<br>  object({<br>    actions   = list(string),<br>    resources = list(string),<br>    effect    = string<br>  })<br>  )</pre> | `[]` | no |
| price\_class | n/a | `string` | `"PriceClass_100"` | no |
| publish | n/a | `bool` | `null` | no |
| robots\_file | n/a | `string` | `""` | no |
| root\_file | n/a | `string` | `""` | no |
| runtime | n/a | `string` | `"nodejs12.x"` | no |
| site\_webmanifest\_file | n/a | `string` | `""` | no |
| sitemap\_file | n/a | `string` | `""` | no |
| timeout | n/a | `number` | `180` | no |
| utils\_file | n/a | `string` | `""` | no |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
| internal\_endpoint | n/a |
| lambda\_arn | n/a |
| lambda\_invoke\_arn | n/a |
| lambda\_name | n/a |
| lambda\_role\_name | n/a |

