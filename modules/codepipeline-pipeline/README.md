## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | n/a | `string` | `"dev"` | no |
| name | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(<br>  object({<br>    actions   = list(string),<br>    resources = list(string),<br>    effect    = string<br>  })<br>  )</pre> | `[]` | no |
| stages | n/a | <pre>list(object({<br>    type     = string<br>    name     = string<br>    provider = string<br>    config   = map(string)<br>    inputs   = list(string)<br>    outputs  = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| artifacts\_bucket | n/a |
| artifacts\_bucket\_arn | n/a |
| id | n/a |
| name | n/a |
| role\_arn | n/a |

