## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_file | n/a | `string` | `""` | no |
| dns | n/a | `string` | n/a | yes |
| dns\_zone | n/a | `string` | n/a | yes |
| env | n/a | `string` | n/a | yes |
| handler | n/a | `string` | `"index.handler"` | no |
| memory\_size | n/a | `number` | `512` | no |
| policy\_statements | n/a | <pre>list(<br>  object({<br>    actions   = list(string),<br>    resources = list(string),<br>    effect    = string<br>  })<br>  )</pre> | `[]` | no |
| runtime | n/a | `string` | `"nodejs12.x"` | no |
| timeout | n/a | `number` | `180` | no |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
| lambda\_arn | n/a |
| lambda\_invoke\_arn | n/a |
| lambda\_name | n/a |
| lambda\_role\_name | n/a |

