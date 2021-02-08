## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| definition | n/a | `string` | n/a | yes |
| enabled | n/a | `bool` | `true` | no |
| name | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(object({<br>    actions = list(string),<br>    resources = list(string),<br>    effect = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |

