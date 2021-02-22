## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| code\_dir | n/a | `string` | n/a | yes |
| config\_file | n/a | `string` | `""` | no |
| config\_statics\_file | n/a | `string` | `""` | no |
| handler | n/a | `string` | `"index.handler"` | no |
| healthz\_file | n/a | `string` | `""` | no |
| memory\_size | n/a | `number` | `128` | no |
| name | n/a | `string` | n/a | yes |
| package\_file | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(<br>    object({<br>      actions   = list(string),<br>      resources = list(string),<br>      effect    = string<br>    })<br>  )</pre> | `[]` | no |
| publish | n/a | `bool` | `false` | no |
| robots\_file | n/a | `string` | `""` | no |
| root\_file | n/a | `string` | `""` | no |
| runtime | n/a | `string` | `"nodejs12.x"` | no |
| site\_webmanifest\_file | n/a | `string` | `""` | no |
| sitemap\_file | n/a | `string` | `""` | no |
| timeout | n/a | `number` | `3` | no |
| utils\_file | n/a | `string` | `""` | no |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| invoke\_arn | n/a |
| name | n/a |
| qualified\_arn | n/a |
| role\_arn | n/a |
| role\_name | n/a |
| version | n/a |

