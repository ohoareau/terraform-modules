## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | n/a | `bool` | `true` | no |
| handler | n/a | `string` | `""` | no |
| memory\_size | n/a | `number` | `256` | no |
| name | n/a | `string` | `""` | no |
| policy\_statements | n/a | <pre>list(object({<br>    actions = list(string),<br>    resources = list(string),<br>    effect = string,<br>  }))</pre> | `[]` | no |
| required\_external\_operations | n/a | `list(string)` | `[]` | no |
| resolvers | n/a | <pre>list(<br>  object({<br>    api = string,<br>    type = string,<br>    field = string,<br>    mode = string,<br>    config = map(string),<br>  })<br>  )</pre> | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
| timeout | n/a | `number` | `10` | no |
| type | n/a | <pre>object({<br>    name = string,<br>    full_name = string,<br>    prefix = string,<br>    full_upper_name = string,<br>    full_upper_name_plural = string,<br>    dynamodb-table = object({<br>      arn: string,<br>    }),<br>    microservice = object({<br>      env = string,<br>      file = string,<br>      name = string,<br>      prefix = string,<br>      table_prefix = string,<br>      dlq_sns_topic = string,<br>      registered_external_operations = map(object({<br>        variable: string,<br>        arn: string,<br>      })),<br>      apis = map(<br>      object({<br>        id = string,<br>        assume_role_arn = string,<br>      }),<br>      ),<br>      sns_topics = map(<br>      object({<br>        arn = string,<br>      })<br>      ),<br>      variables = map(string),<br>      dynamodb_tables = map(<br>        object({<br>          arn = string,<br>        })<br>      ),<br>    })<br>  })</pre> | n/a | yes |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_arn | n/a |
| lambda\_role\_arn | n/a |
| lambda\_role\_name | n/a |
| local\_name | n/a |

