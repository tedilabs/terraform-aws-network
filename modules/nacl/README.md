# nacl

This module creates following resources.

- `aws_network_acl`
- `aws_network_acl_rule` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.30 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.30 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Desired name for the network ACL resources. | `string` | n/a | yes |
| vpc\_id | The ID of the associated VPC. | `string` | n/a | yes |
| egress\_rules | A map of egress rules in a network ACL. Use the key of map as the rule number. | `map(map(any))` | `{}` | no |
| ingress\_rules | A map of ingress rules in a network ACL. Use the key of map as the rule number. | `map(map(any))` | `{}` | no |
| module\_tags\_enabled | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| resource\_group\_description | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| resource\_group\_enabled | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| resource\_group\_name | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| subnets | A list of subnet IDs to apply the ACL to. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the network ACL. |
| associated\_subnets | A list of subnet IDs which is associated with the network ACL. |
| id | The ID of the network ACL. |
| owner\_id | The ID of the AWS account that owns the network ACL. |
| resource\_group\_enabled | Whether Resource Group is enabled. |
| resource\_group\_name | The name of Resource Group. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
