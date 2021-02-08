## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.acm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apex\_redirect | n/a | `bool` | `false` | no |
| bucket\_cors | n/a | `bool` | `false` | no |
| bucket\_name | n/a | `string` | n/a | yes |
| dns | n/a | `string` | n/a | yes |
| error\_403\_page\_path | n/a | `string` | `""` | no |
| error\_403\_path | kept for compatibility, not used, use error\_403\_page\_path instead | `string` | `""` | no |
| error\_404\_page\_path | n/a | `string` | `""` | no |
| error\_404\_path | kept for compatibility, not used, use error\_404\_page\_path instead | `string` | `""` | no |
| error\_document | n/a | `string` | `""` | no |
| forward\_query\_string | n/a | `bool` | `false` | no |
| geolocations | n/a | `list(string)` | <pre>[<br>  "FR",<br>  "BE",<br>  "LU",<br>  "IT",<br>  "ES",<br>  "CH",<br>  "NL",<br>  "GB",<br>  "PT",<br>  "MC"<br>]</pre> | no |
| index\_document | n/a | `string` | `"index.html"` | no |
| lambdas | n/a | <pre>list(object({<br>    event_type = string<br>    lambda_arn = string<br>    include_body = bool<br>  }))</pre> | `[]` | no |
| name | n/a | `string` | n/a | yes |
| price\_class | n/a | `string` | `"PriceClass_100"` | no |
| zone | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | n/a |
| bucket\_id | n/a |
| bucket\_name | n/a |
| cloudfront\_id | n/a |
| dns | n/a |

