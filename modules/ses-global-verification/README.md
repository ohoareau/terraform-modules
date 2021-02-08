## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | n/a | `string` | n/a | yes |
| identities | n/a | <pre>map(object({<br>    id                 = string<br>    verification_token = string<br>    region             = string<br>  }))</pre> | n/a | yes |
| zone | n/a | `string` | n/a | yes |

## Outputs

No output.

