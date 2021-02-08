@deprecated

@see  
  module '../ses-global' (global, only one)  
  module '../ses-regional-identity' (local, one per region)  
  module '../ses-global-verification' (global, only one)

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
| emails | n/a | `map(string)` | `{}` | no |
| name | n/a | `string` | n/a | yes |
| service\_sources | n/a | `list(string)` | `[]` | no |
| sources | n/a | `list(string)` | `[]` | no |
| zone | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| domain | n/a |
| email\_identities | n/a |
| identity | n/a |
| identity\_arn | n/a |
| verification\_token | n/a |

