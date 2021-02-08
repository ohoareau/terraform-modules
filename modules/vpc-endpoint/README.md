## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.26 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.26 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| private\_dns\_enabled | n/a | `bool` | `true` | no |
| route\_table\_id | n/a | `string` | `null` | no |
| security\_group\_ids | n/a | `list(string)` | `[]` | no |
| service | n/a | `string` | n/a | yes |
| subnet\_ids | n/a | `list(string)` | `[]` | no |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| id | n/a |
| service\_name | n/a |

