## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_role\_identifiers | n/a | `list(string)` | `[]` | no |
| dlq\_sns\_topic | n/a | `string` | `""` | no |
| enabled | n/a | `bool` | `true` | no |
| file | n/a | `string` | n/a | yes |
| handler | n/a | `string` | `"index.handler"` | no |
| layers | n/a | `list(string)` | `[]` | no |
| memory\_size | n/a | `number` | `128` | no |
| name | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(<br>    object({<br>      actions   = list(string),<br>      resources = list(string),<br>      effect    = string<br>    })<br>  )</pre> | `[]` | no |
| publish | n/a | `bool` | `false` | no |
| runtime | n/a | `string` | `"nodejs12.x"` | no |
| security\_group\_ids | n/a | `list(string)` | `[]` | no |
| subnet\_ids | n/a | `list(string)` | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
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

