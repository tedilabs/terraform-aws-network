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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.23.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_main_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association) | resource |
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
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the route table resources. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Required) The ID of the VPC which the route table belongs to. | `string` | n/a | yes |
| <a name="input_gateways"></a> [gateways](#input\_gateways) | (Optional) A list of gateway IDs to associate with the route table. Only support Internet Gateway and Virtual Private Gateway. | `list(string)` | `[]` | no |
| <a name="input_ipv4_routes"></a> [ipv4\_routes](#input\_ipv4\_routes) | (Optional) A list of route rules for destinations to IPv4 CIDRs. Each block of `ipv4_routes` as defined below.<br>    (Required) `destination` - The destination IPv4 CIDR block of the route rule.<br>    (Required) `target` - A configuration of the target of the route rule. `target` as defined below.<br>      (Required) `type` - The type of the target of the route rule. Valid values are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`.<br>      (Required) `id` - The ID of the target of the route rule. | <pre>list(object({<br>    destination = string<br><br>    target = object({<br>      type = string<br>      id   = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_ipv6_routes"></a> [ipv6\_routes](#input\_ipv6\_routes) | (Optional) A list of route rules for destinations to IPv6 CIDRs. Each block of `ipv6_routes` as defined below.<br>    (Required) `destination` - The destination IPv6 CIDR block of the route rule.<br>    (Required) `target` - A configuration of the target of the route rule. `target` as defined below.<br>      (Required) `type` - The type of the target of the route rule. Valid values are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`.<br>      (Required) `id` - The ID of the target of the route rule. | <pre>list(object({<br>    destination = string<br><br>    target = object({<br>      type = string<br>      id   = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_is_main"></a> [is\_main](#input\_is\_main) | (Optional) Whether to set this route table as the main route table. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_prefix_list_routes"></a> [prefix\_list\_routes](#input\_prefix\_list\_routes) | (Optional) A list of route rules for destinations to Prefix Lists. Each block of `prefix_list_routes` as defined below.<br>    (Required) `name` - The name of the route rule.<br>    (Required) `destination` - The destination Prefix List of the route rule.<br>    (Required) `target` - A configuration of the target of the route rule. `target` as defined below.<br>      (Required) `type` - The type of the target of the route rule. Valid values are `CARRIER_GATEWAY`, `CORE_GATEWAY`, `EGRESS_ONLY_INTERNET_GATEWAY`, `INTERNET_GATEWAY`, `VPN_GATEWAY`, `LOCAL_GATEWAY`, `NAT_GATEWAY`, `NETWORK_INTERFACE`, `TRANSIT_GATEWAY`, `VPC_ENDPOINT`, `VPC_PEERING_CONNECTION`.<br>      (Required) `id` - The ID of the target of the route rule. | <pre>list(object({<br>    name        = string<br>    destination = string<br><br>    target = object({<br>      type = string<br>      id   = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_propagating_vpn_gateways"></a> [propagating\_vpn\_gateways](#input\_propagating\_vpn\_gateways) | (Optional) A list of Virtual Private Gateway IDs to propagate routes from. | `list(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) A list of subnet IDs to associate with the route table. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the route table to be created/updated/deleted. | <pre>object({<br>    create = optional(string, "5m")<br>    update = optional(string, "2m")<br>    delete = optional(string, "5m")<br>  })</pre> | `{}` | no |
| <a name="input_vpc_gateway_endpoints"></a> [vpc\_gateway\_endpoints](#input\_vpc\_gateway\_endpoints) | (Optional) A list of the VPC Endpoint IDs with which the Route Table will be associated. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the routing table. |
| <a name="output_associated_gateways"></a> [associated\_gateways](#output\_associated\_gateways) | A list of gateway IDs which is associated with the route table. |
| <a name="output_associated_subnets"></a> [associated\_subnets](#output\_associated\_subnets) | A list of subnet IDs which is associated with the route table. |
| <a name="output_associated_vpc_gateway_endpoints"></a> [associated\_vpc\_gateway\_endpoints](#output\_associated\_vpc\_gateway\_endpoints) | A list of the VPC Gateway Endpoint IDs which is associated with the route table. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the routing table. |
| <a name="output_ipv4_routes"></a> [ipv4\_routes](#output\_ipv4\_routes) | A list of route rules for destinations to IPv4 CIDRs. |
| <a name="output_ipv6_routes"></a> [ipv6\_routes](#output\_ipv6\_routes) | A list of route rules for destinations to IPv6 CIDRs. |
| <a name="output_is_main"></a> [is\_main](#output\_is\_main) | Whether to set this route table as the main route table. |
| <a name="output_owner"></a> [owner](#output\_owner) | The ID of the AWS account that owns subnets in the routing table. |
| <a name="output_prefix_list_routes"></a> [prefix\_list\_routes](#output\_prefix\_list\_routes) | A list of route rules for destinations to Prefix Lists. |
| <a name="output_propagated_vpn_gateways"></a> [propagated\_vpn\_gateways](#output\_propagated\_vpn\_gateways) | A list of Virtual Private Gateway IDs which propagate routes from. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC which the route table belongs to. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
