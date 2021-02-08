## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apns | n/a | <pre>object({<br>    certificate  = string<br>    private_key  = string<br>    bundle_id    = string<br>    team_id      = string<br>    token_key    = string<br>    token_key_id = string<br>  })</pre> | `null` | no |
| apns\_sandbox | n/a | <pre>object({<br>    certificate  = string<br>    private_key  = string<br>    bundle_id    = string<br>    team_id      = string<br>    token_key    = string<br>    token_key_id = string<br>  })</pre> | `null` | no |
| apns\_voip | n/a | <pre>object({<br>    certificate  = string<br>    private_key  = string<br>    bundle_id    = string<br>    team_id      = string<br>    token_key    = string<br>    token_key_id = string<br>  })</pre> | `null` | no |
| apns\_voip\_sandbox | n/a | <pre>object({<br>    certificate  = string<br>    private_key  = string<br>    bundle_id    = string<br>    team_id      = string<br>    token_key    = string<br>    token_key_id = string<br>  })</pre> | `null` | no |
| assume\_role\_identifiers | n/a | `list(string)` | `[]` | no |
| baidu | n/a | <pre>object({<br>    api_key    = string<br>    secret_key = string<br>  })</pre> | `null` | no |
| email | n/a | <pre>object({<br>    from     = string<br>    identity = string<br>  })</pre> | `null` | no |
| name | n/a | `string` | n/a | yes |
| sms | n/a | <pre>object({<br>    sender     = string<br>    short_code = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_id | n/a |
| arn | n/a |
| role\_arn | n/a |
| role\_name | n/a |

