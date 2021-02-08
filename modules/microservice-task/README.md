## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster | n/a | `string` | `""` | no |
| command | n/a | `list(string)` | `[]` | no |
| definition\_file | n/a | `string` | `""` | no |
| definition\_vars | n/a | `map(string)` | `{}` | no |
| enabled | n/a | `bool` | `true` | no |
| entrypoint | n/a | `list(string)` | `[]` | no |
| image | n/a | `string` | n/a | yes |
| microservice | n/a | <pre>object({<br>    name = string,<br>    env = string,<br>    file = string,<br>    prefix = string,<br>    dlq_sns_topic = string,<br>    table_prefix = string,<br>    tasks_cluster = string,<br>    tasks_vpc_subnets = list(string)<br>    tasks_vpc_security_groups = list(string)<br>    apis = map(<br>    object({<br>      id = string,<br>      assume_role_arn = string,<br>    }),<br>    ),<br>    sns_topics = map(<br>    object({<br>      arn = string,<br>    })<br>    ),<br>    variables = map(string),<br>    dynamodb_tables = map(<br>    object({<br>      arn = string,<br>    })<br>    ),<br>  })</pre> | n/a | yes |
| name | n/a | `string` | `""` | no |
| policy\_statements | n/a | <pre>list(object({<br>    actions = list(string),<br>    resources = list(string),<br>    effect = string,<br>  }))</pre> | `[]` | no |
| security\_groups | n/a | `list(string)` | `[]` | no |
| subnets | n/a | `list(string)` | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_id | n/a |
| service\_name | n/a |
| task\_arn | n/a |
| task\_id | n/a |

