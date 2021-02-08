## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | n/a | `bool` | `true` | no |
| handler | n/a | `string` | n/a | yes |
| memory\_size | n/a | `number` | `128` | no |
| microservice | n/a | <pre>object({<br>    name = string,<br>    env = string,<br>    file = string,<br>    prefix = string,<br>    table_prefix = string,<br>    dlq_sns_topic = string,<br>    apis = map(<br>      object({<br>        id = string,<br>        assume_role_arn = string,<br>      }),<br>    ),<br>    sns_topics = map(<br>      object({<br>        arn = string,<br>      })<br>    ),<br>    variables = map(string),<br>    dynamodb_tables = map(<br>      object({<br>        arn = string,<br>      })<br>    ),<br>  })</pre> | n/a | yes |
| name | n/a | `string` | `""` | no |
| policy\_statements | n/a | <pre>list(object({<br>    actions = list(string),<br>    resources = list(string),<br>    effect = string,<br>  }))</pre> | n/a | yes |
| resolvers | n/a | <pre>list(<br>    object({<br>      api = string,<br>      type = string,<br>      field = string,<br>      mode = string,<br>      config = map(string),<br>    }<br>  ))</pre> | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
| timeout | n/a | `number` | `3` | no |
| variables | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_arn | n/a |
| lambda\_role\_arn | n/a |
| lambda\_role\_name | n/a |

