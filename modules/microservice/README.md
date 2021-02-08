## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api | n/a | `string` | `""` | no |
| api\_name | n/a | `string` | `""` | no |
| buckets | n/a | <pre>map(object({<br>    prefix = string,<br>    tags = map(string),<br>    cors = bool<br>  }))</pre> | `{}` | no |
| debug | n/a | `bool` | `false` | no |
| dlq\_sns\_topic | n/a | `string` | `""` | no |
| env | n/a | `string` | n/a | yes |
| file | n/a | `string` | n/a | yes |
| name | n/a | `string` | n/a | yes |
| public\_api | n/a | `string` | `""` | no |
| public\_api\_name | n/a | `string` | `""` | no |
| required\_types | n/a | `map(map(map(object({}))))` | `{}` | no |
| tasks\_cluster | n/a | `string` | `""` | no |
| tasks\_vpc\_security\_groups | n/a | `list(string)` | `[]` | no |
| tasks\_vpc\_subnets | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| apis | n/a |
| debug | n/a |
| dlq\_sns\_topic | n/a |
| dynamodb\_tables | n/a |
| env | n/a |
| file | n/a |
| name | n/a |
| prefix | n/a |
| registered\_external\_operations | n/a |
| required\_types | n/a |
| s3\_buckets | n/a |
| sns\_topics | n/a |
| sqs\_queues | n/a |
| table\_prefix | n/a |
| tasks\_cluster | n/a |
| tasks\_vpc\_security\_groups | n/a |
| tasks\_vpc\_subnets | n/a |
| variables | n/a |

