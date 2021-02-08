## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_block | n/a | `string` | n/a | yes |
| dns\_hostnames | n/a | `bool` | `true` | no |
| dns\_support | n/a | `bool` | `true` | no |
| env | n/a | `string` | n/a | yes |
| name | n/a | `string` | `"network"` | no |
| security\_group | n/a | `bool` | `false` | no |
| security\_group\_allow\_internal\_https | n/a | `bool` | `false` | no |
| security\_group\_allow\_internal\_smtps | n/a | `bool` | `false` | no |
| security\_group\_allow\_outgoing | n/a | `bool` | `false` | no |
| subnets | n/a | <pre>map(object({<br>    public: bool,<br>    cidr_block: string<br>    availability_zone: string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_tables | n/a |
| security\_group\_arn | n/a |
| security\_group\_id | n/a |
| security\_group\_name | n/a |
| subnets | n/a |
| vpc\_arn | n/a |
| vpc\_id | n/a |
| vpc\_name | n/a |

