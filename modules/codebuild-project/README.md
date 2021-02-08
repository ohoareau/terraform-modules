## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| build\_timeout | n/a | `number` | `5` | no |
| buildspec\_file | n/a | `string` | n/a | yes |
| compute\_type | n/a | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| env | n/a | `string` | `"dev"` | no |
| image | n/a | `string` | n/a | yes |
| name | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(<br>  object({<br>    actions   = list(string),<br>    resources = list(string),<br>    effect    = string<br>  })<br>  )</pre> | `[]` | no |
| queued\_timeout | n/a | `number` | `5` | no |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| artifacts | n/a |
| badge\_url | n/a |
| id | n/a |
| name | n/a |
| role\_arn | n/a |
| role\_name | n/a |

