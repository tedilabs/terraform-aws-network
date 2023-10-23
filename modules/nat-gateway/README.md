# nat-gateway

This module creates following resources.

- `aws_nat_gateway`
- `aws_eip` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.10 |

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
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the NAT Gateway resources. | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | (Required) The Subnet ID of the subnet in which to place the NAT Gateway. | `string` | n/a | yes |
| <a name="input_is_private"></a> [is\_private](#input\_is\_private) | (Optional) Whether to create the NAT gateway as private or public connectivity type. Defaults to `false` (public). | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_primary_ip_assignment"></a> [primary\_ip\_assignment](#input\_primary\_ip\_assignment) | (Optional) A configuration to assign primary ip address with the NAT Gateway. `primary_ip_assignment` as defined below.<br>    (Optional) `elastic_ip` - The allocation ID of Elastic IP address to associate with the NAT Gateway.<br>    (Optional) `private_ip` - The private IP address to associate with the NAT Gateway. If you dont't provide an address, a private IPv4 address will be automatically assigned. | <pre>object({<br>    elastic_ip = optional(string)<br>    private_ip = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_secondary_ip_assignments"></a> [secondary\_ip\_assignments](#input\_secondary\_ip\_assignments) | (Optional) A configuration to assign secondary ip addresses with the NAT Gateway. Each block of `secondary_ip_assignments` as defined below.<br>    (Optional) `elastic_ip` - The allocation ID of Elastic IP address to associate with the NAT Gateway.<br>    (Optional) `private_ip` - The private IP address to associate with the NAT Gateway. If you dont't provide an address, a private IPv4 address will be automatically assigned. | <pre>list(object({<br>    elastic_ip = optional(string)<br>    private_ip = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_secondary_ip_count"></a> [secondary\_ip\_count](#input\_secondary\_ip\_count) | (Optional) The number of secondary private IPv4 addresses to assign to the NAT Gateway. Only used with private NAT Gateway. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the NAT Gateway to be created/updated/deleted. | <pre>object({<br>    create = optional(string, "10m")<br>    update = optional(string, "10m")<br>    delete = optional(string, "30m")<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | The availability zone of the NAT Gateway.<br>    `id` - The ID of the availability zone.<br>    `name` - The name of the availability zone. |
| <a name="output_elastic_ip"></a> [elastic\_ip](#output\_elastic\_ip) | The Allocation ID of the Elastic IP address for the gateway. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the NAT Gateway. |
| <a name="output_is_private"></a> [is\_private](#output\_is\_private) | Whether the NAT Gateway supports public or private connectivity. |
| <a name="output_name"></a> [name](#output\_name) | The name of the NAT Gateway. |
| <a name="output_netework_interface"></a> [netework\_interface](#output\_netework\_interface) | The ENI ID of the network interface created by the NAT gateway. |
| <a name="output_primary_private_ip"></a> [primary\_private\_ip](#output\_primary\_private\_ip) | The private IP address of the NAT Gateway. |
| <a name="output_primary_public_ip"></a> [primary\_public\_ip](#output\_primary\_public\_ip) | The public IP address of the NAT Gateway. |
| <a name="output_secondary_private_ips"></a> [secondary\_private\_ips](#output\_secondary\_private\_ips) | The secondary private IP addresses of the NAT Gateway. |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | The subnet which the NAT Gateway belongs to.<br>    `id` - The ID of the subnet.<br>    `arn` - The ARN of the subnet. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID of the NAT Gateway. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
