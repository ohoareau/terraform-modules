## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | n/a | `bool` | `true` | no |
| name | n/a | `string` | `""` | no |
| name\_prefix | n/a | `string` | `"policy-"` | no |
| role\_name | n/a | `string` | n/a | yes |
| statements | n/a | <pre>list(<br>  object({<br>    actions   = list(string),<br>    resources = list(string),<br>    effect    = string<br>  })<br>  )</pre> | `[]` | no |

## Outputs

No output.

