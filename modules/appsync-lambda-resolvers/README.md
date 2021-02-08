## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api | n/a | `string` | n/a | yes |
| api\_name | n/a | `string` | n/a | yes |
| datasources | n/a | `map(string)` | `{}` | no |
| enabled | n/a | `bool` | `true` | no |
| lambdas | n/a | `list(string)` | `[]` | no |
| mutations | n/a | `map(object({type: string, config: map(string)}))` | `{}` | no |
| name | n/a | `string` | n/a | yes |
| queries | n/a | `map(object({type: string, config: map(string)}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| api\_assume\_role\_arn | n/a |

