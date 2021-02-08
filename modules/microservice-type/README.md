## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| microservice | n/a | <pre>object({<br>    env = string,<br>    debug = bool,<br>    file = string,<br>    name = string,<br>    prefix = string,<br>    dlq_sns_topic = string,<br>    registered_external_operations = map(object({<br>      variable: string,<br>      arn: string,<br>    })),<br>    table_prefix = string,<br>    tasks_cluster = string,<br>    tasks_vpc_subnets = list(string)<br>    tasks_vpc_security_groups = list(string)<br>    apis = map(<br>    object({<br>      id = string,<br>      assume_role_arn = string,<br>    }),<br>    ),<br>    sns_topics = map(<br>    object({<br>      arn = string,<br>    })<br>    ),<br>    variables = map(string),<br>    dynamodb_tables = map(<br>      object({<br>        arn = string,<br>      })<br>    ),<br>  })</pre> | n/a | yes |
| name | n/a | `string` | n/a | yes |
| name\_plural | n/a | `string` | `""` | no |
| parent | n/a | <pre>object({<br>    full_name       = string,<br>    upper_name      = string,<br>    full_upper_name = string,<br>  })</pre> | `null` | no |
| table\_attributes | n/a | <pre>map(<br>    object({<br>      type = string<br>    })<br>  )</pre> | <pre>{<br>  "id": {<br>    "type": "S"<br>  }<br>}</pre> | no |
| table\_indexes | n/a | <pre>map(<br>    object({<br>      type = string<br>    })<br>  )</pre> | `{}` | no |
| tags | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb-table | n/a |
| full\_name | n/a |
| full\_name\_plural | n/a |
| full\_upper\_name | n/a |
| full\_upper\_name\_plural | n/a |
| microservice | n/a |
| name | n/a |
| name\_plural | n/a |
| prefix | n/a |
| table\_prefix | n/a |
| upper\_name | n/a |
| upper\_name\_plural | n/a |

