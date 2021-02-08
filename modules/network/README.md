## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_block | n/a | `string` | n/a | yes |
| dns\_hostnames | n/a | `bool` | `true` | no |
| dns\_support | n/a | `bool` | `true` | no |
| enabled | n/a | `bool` | `true` | no |
| env | n/a | `string` | n/a | yes |
| security\_groups | n/a | <pre>map(object({<br>    egress = list(object({<br>      from_port   = number,<br>      to_port     = number,<br>      protocol    = string,<br>      cidr_blocks = list(string),<br>    }))<br>  }))</pre> | `{}` | no |
| subnets | n/a | <pre>map(object({<br>    public: bool,<br>    cidr_block: string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| cidr\_block | n/a |
| id | n/a |
| private\_subnets | n/a |
| public\_subnets | n/a |
| security\_groups | n/a |
| subnets | n/a |

