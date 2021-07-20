# route-table

This module creates following resources.

- `aws_route_table`
- `aws_route` (optional)
- `aws_main_route_table_association` (optional)
- `aws_route_table_association` (optional)
- `aws_vpc_endpoint_route_table_association` (optional)
- `aws_vpn_gateway_route_propagation` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_main_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_route.ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.prefix_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.gateways](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpn_gateway_route_propagation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway_route_propagation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Desired name for the route table resources. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC which the route table belongs to. | `string` | n/a | yes |
| <a name="input_gateways"></a> [gateways](#input\_gateways) | A list of gateway IDs to associate with the route table. Only support Internet Gateway and Virtual Private Gateway. | `list(string)` | `[]` | no |
| <a name="input_ipv4_routes"></a> [ipv4\_routes](#input\_ipv4\_routes) | A list of route rules for IPv4 CIDRs. | `list(map(string))` | `[]` | no |
| <a name="input_ipv6_routes"></a> [ipv6\_routes](#input\_ipv6\_routes) | A list of route rules for IPv6 CIDRs. | `list(map(string))` | `[]` | no |
| <a name="input_is_main"></a> [is\_main](#input\_is\_main) | Whether to set this route table as the main route table. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_prefix_list_routes"></a> [prefix\_list\_routes](#input\_prefix\_list\_routes) | A list of route rules for Managed Prefix List. | `list(map(string))` | `[]` | no |
| <a name="input_propagating_vpn_gateways"></a> [propagating\_vpn\_gateways](#input\_propagating\_vpn\_gateways) | A list of Virtual Private Gateway IDs to propagate routes from. | `list(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to associate with the route table. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_gateway_endpoints"></a> [vpc\_gateway\_endpoints](#input\_vpc\_gateway\_endpoints) | A list of the VPC Endpoint IDs with which the Route Table will be associated. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_associated_gateways"></a> [associated\_gateways](#output\_associated\_gateways) | A list of gateway IDs which is associated with the route table. |
| <a name="output_associated_subnets"></a> [associated\_subnets](#output\_associated\_subnets) | A list of subnet IDs which is associated with the route table. |
| <a name="output_associated_vpc_gateway_endpoints"></a> [associated\_vpc\_gateway\_endpoints](#output\_associated\_vpc\_gateway\_endpoints) | A list of the VPC Gateway Endpoint IDs which is associated with the route table. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the routing table. |
| <a name="output_is_main"></a> [is\_main](#output\_is\_main) | Whether to set this route table as the main route table. |
| <a name="output_propagated_vpn_gateways"></a> [propagated\_vpn\_gateways](#output\_propagated\_vpn\_gateways) | A list of Virtual Private Gateway IDs which propagate routes from. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC which the route table belongs to. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
