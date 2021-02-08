## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api | n/a | `string` | `""` | no |
| api\_mutation\_aliases | n/a | `map(object({operation: string, config: map(string)}))` | `{}` | no |
| api\_name | n/a | `string` | `""` | no |
| api\_operations | n/a | `map(bool)` | `{}` | no |
| api\_query\_aliases | n/a | `map(object({operation: string, config: map(string)}))` | `{}` | no |
| debug | n/a | `bool` | `false` | no |
| enabled\_operations | n/a | `map(bool)` | `{}` | no |
| env | n/a | `string` | n/a | yes |
| file | n/a | `string` | n/a | yes |
| name | n/a | `string` | n/a | yes |
| name\_plural | n/a | `string` | `""` | no |
| operations | n/a | <pre>map(<br>    object({<br>      variables = map(string),<br>      policy_statements = list(<br>        object({<br>          actions = list(string),<br>          resources = list(string),<br>          effect = string<br>        })<br>      )<br>    })<br>  )</pre> | `{}` | no |
| public\_api | n/a | `string` | `""` | no |
| public\_api\_mutation\_aliases | n/a | `map(object({operation: string, config: map(string)}))` | `{}` | no |
| public\_api\_name | n/a | `string` | `""` | no |
| public\_api\_query\_aliases | n/a | `map(object({operation: string, config: map(string)}))` | `{}` | no |
| queues | n/a | <pre>map(<br>    object({<br>      sources = list(string)<br>    })<br>  )</pre> | `{}` | no |
| tables\_attributes | n/a | <pre>map(<br>    map(<br>      object({<br>        type = string<br>      })<br>    )<br>  )</pre> | `{}` | no |
| tables\_indexes | n/a | <pre>map(<br>    map(<br>      object({<br>        type = string<br>      })<br>    )<br>  )</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb\_tables | n/a |
| lambdas | n/a |
| sns\_topics | n/a |
| sqs\_queues | n/a |

