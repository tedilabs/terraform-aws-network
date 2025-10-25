# nat-gateway

This module creates following resources.

- `aws_nat_gateway`
- `aws_nat_gateway_eip_association` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.18.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway_eip_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway_eip_association) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the NAT Gateway resources. | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | (Required) The Subnet ID of the subnet in which to place the NAT Gateway. | `string` | n/a | yes |
| <a name="input_is_private"></a> [is\_private](#input\_is\_private) | (Optional) Whether to create the NAT gateway as private or public connectivity type. Defaults to `false` (public). | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_private_ip_assignments"></a> [private\_ip\_assignments](#input\_private\_ip\_assignments) | (Optional) A configuration to assign private ip addresses with the NAT Gateway. `private_ip_assignments` as defined below.<br/>    (Optional) `primary_private_ip` - The private IP address to associate with the NAT Gateway. If you dont't provide an address, a private IPv4 address will be automatically assigned.<br/>    (Optional) `secondary_private_ips` - A set of secondary private IPv4 addresses to assign to the NAT Gateway.<br/>    (Optional) `secondary_private_ip_count` - The number of secondary private IPv4 addresses to assign to the NAT Gateway. | <pre>object({<br/>    primary_private_ip         = optional(string)<br/>    secondary_private_ips      = optional(set(string), [])<br/>    secondary_private_ip_count = optional(number, 0)<br/>  })</pre> | `{}` | no |
| <a name="input_public_ip_assignments"></a> [public\_ip\_assignments](#input\_public\_ip\_assignments) | (Optional) A configuration to assign public ip addresses with the NAT Gateway. `public_ip_assignments` as defined below.<br/>    (Optional) `primary_elastic_ip` - The allocation ID of Elastic IP address to associate with the NAT Gateway.<br/>    (Optional) `secondary_elastic_ips` - A set of allocation IDs of Elastic IP addresses to associate with the NAT Gateway as secondary IPs. | <pre>object({<br/>    primary_elastic_ip    = optional(string)<br/>    secondary_elastic_ips = optional(set(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the NAT Gateway to be created/updated/deleted. | <pre>object({<br/>    create = optional(string, "10m")<br/>    update = optional(string, "10m")<br/>    delete = optional(string, "30m")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | The availability zone of the NAT Gateway.<br/>    `id` - The ID of the availability zone.<br/>    `name` - The name of the availability zone. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the NAT Gateway. |
| <a name="output_is_private"></a> [is\_private](#output\_is\_private) | Whether the NAT Gateway supports public or private connectivity. |
| <a name="output_name"></a> [name](#output\_name) | The name of the NAT Gateway. |
| <a name="output_netework_interface"></a> [netework\_interface](#output\_netework\_interface) | The ENI ID of the network interface created by the NAT gateway. |
| <a name="output_primary_private_ip"></a> [primary\_private\_ip](#output\_primary\_private\_ip) | The private IP address of the NAT Gateway. |
| <a name="output_primary_public_ip"></a> [primary\_public\_ip](#output\_primary\_public\_ip) | The public IP address of the NAT Gateway. |
| <a name="output_private_ip_assignments"></a> [private\_ip\_assignments](#output\_private\_ip\_assignments) | The private IP address assignments of the NAT Gateway. |
| <a name="output_public_ip_assignments"></a> [public\_ip\_assignments](#output\_public\_ip\_assignments) | The public IP address assignments of the NAT Gateway. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | The subnet which the NAT Gateway belongs to.<br/>    `id` - The ID of the subnet.<br/>    `arn` - The ARN of the subnet. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID of the NAT Gateway. |
<!-- END_TF_DOCS -->
