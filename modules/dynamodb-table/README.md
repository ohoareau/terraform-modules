## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | n/a | `map` | <pre>{<br>  "id": {<br>    "type": "S"<br>  }<br>}</pre> | no |
| billing\_mode | n/a | `string` | `"PROVISIONED"` | no |
| enabled | n/a | `bool` | `true` | no |
| hash\_key | n/a | `string` | `"id"` | no |
| indexes | n/a | `map(any)` | `{}` | no |
| name | n/a | `string` | n/a | yes |
| range\_key | n/a | `string` | `null` | no |
| stream\_type | n/a | `string` | `""` | no |
| tags | n/a | `map(string)` | `{}` | no |
| ttl | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| name | n/a |
| stream\_arn | n/a |
| stream\_label | n/a |

