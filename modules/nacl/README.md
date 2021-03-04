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
| subnets | A list of subnet IDs to apply the ACL to. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the network ACL. |
| associated\_subnets | A list of subnet IDs which is associated with the network ACL. |
| id | The ID of the network ACL. |
| owner\_id | The ID of the AWS account that owns the network ACL. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
