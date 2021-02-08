## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | n/a | `bool` | `true` | no |
| handler | n/a | `string` | `"lambda.handler"` | no |
| layers | n/a | `list(string)` | n/a | yes |
| memory\_size | n/a | `number` | `512` | no |
| name | n/a | `string` | n/a | yes |
| package\_file | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(<br>  object({<br>    actions   = list(string),<br>    resources = list(string),<br>    effect    = string<br>  })<br>  )</pre> | `[]` | no |
| runtime | n/a | `string` | `"provided.al2"` | no |
| tags | n/a | `map(string)` | `{}` | no |
| timeout | n/a | `number` | `60` | no |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns | n/a |
| gateway\_id | n/a |
| gateway\_stage | n/a |
| lambda\_arn | n/a |
| lambda\_invoke\_arn | n/a |
| lambda\_name | n/a |
| lambda\_role\_arn | n/a |
| lambda\_role\_name | n/a |
| url | n/a |

