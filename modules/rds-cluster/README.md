## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| db\_auto\_pause | n/a | `bool` | `true` | no |
| db\_auto\_pause\_delay | n/a | `number` | `300` | no |
| db\_availability\_zones | n/a | `list(string)` | `[]` | no |
| db\_backup\_retention\_period | n/a | `number` | n/a | yes |
| db\_engine | n/a | `string` | `"aurora-mysql"` | no |
| db\_engine\_mode | n/a | `string` | `"serverless"` | no |
| db\_engine\_version | n/a | `string` | `"5.7.mysql_aurora.2.03.2"` | no |
| db\_master\_password | n/a | `string` | n/a | yes |
| db\_master\_username | n/a | `string` | n/a | yes |
| db\_max\_capacity | n/a | `number` | `4` | no |
| db\_min\_capacity | n/a | `number` | `1` | no |
| db\_name | n/a | `string` | n/a | yes |
| db\_preferred\_backup\_window | n/a | `string` | `"07:00-09:00"` | no |
| db\_security\_group\_id | n/a | `string` | `null` | no |
| db\_subnets | n/a | <pre>map(object({<br>    id = string<br>    cidr_block = string<br>  }))</pre> | `{}` | no |
| db\_vpc\_id | n/a | `string` | n/a | yes |
| env | n/a | `string` | n/a | yes |
| name | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| db\_host | n/a |
| db\_name | n/a |
| db\_password | n/a |
| db\_port | n/a |
| db\_security\_group\_id | n/a |
| db\_url | n/a |
| db\_user | n/a |

