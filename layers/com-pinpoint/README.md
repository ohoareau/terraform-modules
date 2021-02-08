## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns | n/a | `string` | n/a | yes |
| env | n/a | `string` | n/a | yes |
| identities | n/a | `map(string)` | `{}` | no |
| pinpoint\_channels | n/a | <pre>object({<br>    email = object({identity = string})<br>  })</pre> | n/a | yes |
| service\_sources | n/a | `list(string)` | `[]` | no |
| sources | n/a | `list(string)` | `[]` | no |
| zone | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| identities | n/a |

