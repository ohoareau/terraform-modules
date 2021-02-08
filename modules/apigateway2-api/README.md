## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cors | n/a | `bool` | `false` | no |
| cors\_config | n/a | <pre>object({<br>    allow_credentials = bool<br>    allow_headers     = list(string)<br>    allow_methods     = list(string)<br>    allow_origins     = list(string)<br>    expose_headers    = list(string)<br>    max_age           = number<br>  })</pre> | <pre>{<br>  "allow_credentials": false,<br>  "allow_headers": [<br>    "*"<br>  ],<br>  "allow_methods": [<br>    "*"<br>  ],<br>  "allow_origins": [<br>    "*"<br>  ],<br>  "expose_headers": [],<br>  "max_age": 300<br>}</pre> | no |
| lambda\_arn | n/a | `string` | n/a | yes |
| name | n/a | `string` | n/a | yes |
| protocol | n/a | `string` | `"HTTP"` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns | n/a |
| endpoint | n/a |
| id | n/a |
| stage | n/a |

