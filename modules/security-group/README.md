# security-group

This module creates following resources.

- `aws_security_group`
- `aws_vpc_security_group_ingress_rule` (optional)
- `aws_vpc_security_group_egress_rule` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the security group. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Required) The ID of the associated VPC. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The security group description. This field maps to the AWS `GroupDescription` attribute, for which there is no Update API. | `string` | `"Managed by Terraform."` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | (Optional) The configuration for egress rules of the security group. Each block of `egress_rules` as defined below.<br>    (Required) `id` - The ID of the egress rule. This value is only used internally within Terraform code.<br>    (Optional) `description` - The description of the rule.<br>    (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.<br>    (Required) `from_port` - The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.<br>    (Required) `to_port` - The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.<br>    (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.<br>    (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.<br>    (Optional) `prefix_lists` - The prefix list IDs to allow.<br>    (Optional) `security_groups` - The source security group IDs to allow.<br>    (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule. | <pre>list(object({<br>    id              = string<br>    description     = optional(string, "Managed by Terraform.")<br>    protocol        = string<br>    from_port       = number<br>    to_port         = number<br>    ipv4_cidrs      = optional(list(string), [])<br>    ipv6_cidrs      = optional(list(string), [])<br>    prefix_lists    = optional(list(string), [])<br>    security_groups = optional(list(string), [])<br>    self            = optional(bool, false)<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | (Optional) The configuration for ingress rules of the security group. Each block of `ingress_rules` as defined below.<br>    (Required) `id` - The ID of the ingress rule. This value is only used internally within Terraform code.<br>    (Optional) `description` - The description of the rule.<br>    (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.<br>    (Required) `from_port` - The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.<br>    (Required) `to_port` - The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.<br>    (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.<br>    (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.<br>    (Optional) `prefix_lists` - The prefix list IDs to allow.<br>    (Optional) `security_groups` - The source security group IDs to allow.<br>    (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule. | <pre>list(object({<br>    id              = string<br>    description     = optional(string, "Managed by Terraform.")<br>    protocol        = string<br>    from_port       = number<br>    to_port         = number<br>    ipv4_cidrs      = optional(list(string), [])<br>    ipv6_cidrs      = optional(list(string), [])<br>    prefix_lists    = optional(list(string), [])<br>    security_groups = optional(list(string), [])<br>    self            = optional(bool, false)<br>  }))</pre> | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | (Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the security group. |
| <a name="output_description"></a> [description](#output\_description) | The description of the security group. |
| <a name="output_egress_rules"></a> [egress\_rules](#output\_egress\_rules) | The configuration of the security group egress rules. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the security group. |
| <a name="output_ingress_rules"></a> [ingress\_rules](#output\_ingress\_rules) | The configuration of the security group ingress rules. |
| <a name="output_name"></a> [name](#output\_name) | The name of the security group. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The ID of the AWS account that owns the security group. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the associated VPC. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
