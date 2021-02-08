## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| archive | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_file | n/a | `string` | `""` | no |
| handler | n/a | `string` | `"index.handler"` | no |
| memory\_size | n/a | `number` | `128` | no |
| name | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(<br>    object({<br>      actions   = list(string),<br>      resources = list(string),<br>      effect    = string<br>    })<br>  )</pre> | `[]` | no |
| runtime | n/a | `string` | `"nodejs12.x"` | no |
| timeout | n/a | `number` | `3` | no |
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

