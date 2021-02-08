## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| events\_policy\_statements | n/a | <pre>list(object({<br>    actions = list(string),<br>    resources = list(string),<br>    effect = string,<br>  }))</pre> | `[]` | no |
| events\_variables | n/a | `map(string)` | `{}` | no |
| microservice | n/a | <pre>object({<br>    env = string,<br>    file = string,<br>    table_prefix = string,<br>    prefix = string,<br>    name = string,<br>    dlq_sns_topic = string,<br>    apis = map(<br>    object({<br>      id = string,<br>      assume_role_arn = string,<br>      assume_role = string,<br>    }),<br>    ),<br>    sns_topics = map(<br>    object({<br>      arn = string,<br>    })<br>    ),<br>    sqs_queues = map(object({<br>      arn = string,<br>    })),<br>    variables = map(string),<br>    dynamodb_tables = map(<br>    object({<br>      arn = string,<br>    })<br>    ),<br>  })</pre> | n/a | yes |
| migrate\_policy\_statements | n/a | <pre>list(object({<br>    actions = list(string),<br>    resources = list(string),<br>    effect = string,<br>  }))</pre> | `[]` | no |
| migrate\_variables | n/a | `map(string)` | `{}` | no |
| operations | n/a | <pre>list(object({<br>    lambda_arn = string,<br>    local_name = string,<br>  }))</pre> | `[]` | no |
| types | n/a | <pre>list(object({<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambdas | n/a |

