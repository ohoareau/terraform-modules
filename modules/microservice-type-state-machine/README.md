## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| definition\_file | n/a | `string` | `""` | no |
| definition\_vars | n/a | `map(string)` | `{}` | no |
| enabled | n/a | `bool` | `true` | no |
| name | n/a | `string` | n/a | yes |
| policy\_statements | n/a | <pre>list(object({<br>    actions = list(string),<br>    resources = list(string),<br>    effect = string,<br>  }))</pre> | `[]` | no |
| type | n/a | <pre>object({<br>    name = string,<br>    full_name = string,<br>    prefix = string,<br>    full_upper_name = string,<br>    full_upper_name_plural = string,<br>    dynamodb-table = object({<br>      arn: string,<br>    }),<br>    microservice = object({<br>      env = string,<br>      name = string,<br>      file = string,<br>      prefix = string,<br>      table_prefix = string,<br>      dlq_sns_topic = string,<br>      registered_external_operations = map(object({<br>        variable: string,<br>        arn: string,<br>      })),<br>      tasks_cluster = string,<br>      tasks_vpc_subnets = list(string)<br>      tasks_vpc_security_groups = list(string)<br>      apis = map(<br>      object({<br>        id = string,<br>        assume_role_arn = string,<br>      }),<br>      ),<br>      sns_topics = map(<br>      object({<br>        arn = string,<br>      })<br>      ),<br>      variables = map(string),<br>      dynamodb_tables = map(<br>      object({<br>        arn = string,<br>      })<br>      ),<br>    })<br>  })</pre> | n/a | yes |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |

