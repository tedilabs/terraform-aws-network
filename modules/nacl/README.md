# nacl

This module creates following resources.

- `aws_network_acl`
- `aws_network_acl_association` (optional)
- `aws_network_acl_rule` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.59 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_network_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the network ACL resources. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Required) The ID of the VPC to associate. | `string` | n/a | yes |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | (Optional) A set of egress rules in the default Network ACL. Use the key of map as the rule number (priority). If not explicitly defined, the AWS default rules are applied. Each block of `egress_rules` as defined below.<br>    (Required) `priority` - The rule priority. The rule number. Used for ordering.<br>    (Required) `action` - The action to indicate whether to allow or deny the traffic that matches the rule. Valid values are `ALLOW` and `DENY`.<br>    (Required) `protocol` - The protocol to match. If using the `-1` 'all' protocol, you must specify a from and to port of `0`.<br>    (Required) `from_port` - The from port to match.<br>    (Required) `to_port` - The to port to match.<br>    (Optional) `ipv4_cidr` - The IPv4 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv6_cidr`.<br>    (Optional) `ipv6_cidr` - The IPv6 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv4_cidr`.<br>    (Optional) `icmp_type` - The ICMP type to be used. Defaults to `0`.<br>    (Optional) `icmp_code` - The ICMP code to be used. Defaults to `0`. | <pre>map(object({<br>    action    = string<br>    protocol  = string<br>    from_port = number<br>    to_port   = number<br>    ipv4_cidr = optional(string)<br>    ipv6_cidr = optional(string)<br>    icmp_type = optional(number, 0)<br>    icmp_code = optional(number, 0)<br>  }))</pre> | `{}` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | (Optional) A map of ingress rules in the default Network ACL. Use the key of map as the rule number (priority). If not explicitly defined, the AWS default rules are applied. Each block of `ingress_rules` as defined below.<br>    (Required) `priority` - The rule priority. The rule number. Used for ordering.<br>    (Required) `action` - The action to indicate whether to allow or deny the traffic that matches the rule. Valid values are `ALLOW` and `DENY`.<br>    (Required) `protocol` - The protocol to match. If using the `-1` `all` protocol, you must specify a from and to port of `0`.<br>    (Required) `from_port` - The from port to match.<br>    (Required) `to_port` - The to port to match.<br>    (Optional) `ipv4_cidr` - The IPv4 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv6_cidr`.<br>    (Optional) `ipv6_cidr` - The IPv6 network range to allow or deny, in CIDR notation. Cannot be specified with `ipv4_cidr`.<br>    (Optional) `icmp_type` - The ICMP type to be used. Defaults to `0`.<br>    (Optional) `icmp_code` - The ICMP code to be used. Defaults to `0`. | <pre>map(object({<br>    action    = string<br>    protocol  = string<br>    from_port = number<br>    to_port   = number<br>    ipv4_cidr = optional(string)<br>    ipv6_cidr = optional(string)<br>    icmp_type = optional(number, 0)<br>    icmp_code = optional(number, 0)<br>  }))</pre> | `{}` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) A list of subnet IDs to apply the ACL to. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the network ACL. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the network ACL. |
| <a name="output_name"></a> [name](#output\_name) | The name of the network ACL. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The ID of the AWS account that owns the network ACL. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A list of subnet IDs which is associated with the network ACL. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID of the network ACL. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
