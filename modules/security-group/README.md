# security-group

This module creates following resources.

- `aws_security_group`
- `aws_security_group_rule` (optional)

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
| vpc\_id | The ID of the associated VPC. | `string` | n/a | yes |
| description | The security group description. This field maps to the AWS `GroupDescription` attribute, for which there is no Update API. | `string` | `"Managed by Terraform."` | no |
| egress\_rules | A list of egress rules in a security group. | `any` | `[]` | no |
| ingress\_rules | A list of ingress rules in a security group. | `any` | `[]` | no |
| name | The name of the security group. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| name\_prefix | Creates a unique name beginning with the specified prefix. Conflicts with `name`. | `string` | `null` | no |
| revoke\_rules\_on\_delete | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed. | `bool` | `false` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the security group. |
| id | The ID of the security group. |
| name | The name of the security group. |
| owner\_id | The ID of the AWS account that owns the security group. |
| vpc\_id | The ID of the associated VPC. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
