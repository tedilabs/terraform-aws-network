# dx-private-virtual-interface

This module creates following resources.

- `aws_dx_private_virtual_interface`
- `aws_dx_bgp_peer` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.60 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dx_bgp_peer.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_bgp_peer) | resource |
| [aws_dx_private_virtual_interface.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_private_virtual_interface) | resource |
| [aws_dx_router_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dx_router_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_peerings"></a> [bgp\_peerings](#input\_bgp\_peerings) | (Required) The configuration for BGP(Border Gateway Protocol) Peerings of the virtual interface. You must create a BGP peer for the corresponding address family (IPv4/IPv6) in order to access AWS resources that also use that address family. If logical redundancy is not supported by the connection, interconnect, or LAG, the BGP peer cannot be in the same address family as an existing BGP peer on the virtual interface. When creating a IPv6 BGP peer, omit the Amazon address and customer address. IPv6 addresses are automatically assigned from the Amazon pool of IPv6 addresses; you cannot specify custom IPv6 addresses. Each block of `bgp_peerings` as defined below.<br>    (Required) `address_family` - The address family for the BGP peer. Valid values are `IPV4` or `IPV6`. Defaults to `IPV4`.<br>    (Required) `bgp_asn` - The Border Gateway Protocol (BGP) Autonomous System Number (ASN) of your on-premises router for the new virtual interface. Valid ranges are 1 - 2147483647.<br>    (Optional) `bgp_auth_key` - The password that will be used to authenticate the BGP session.<br>    (Optional) `amazon_address` - The BGP peer IP configured on the AWS endpoint. Required for IPv4 BGP peering.<br>    (Optional) `customer_address` - The BGP peer IP configured on your endpoint. Required for IPv4 BGP peering. | <pre>list(object({<br>    address_family   = string<br>    bgp_asn          = number<br>    bgp_auth_key     = optional(string)<br>    amazon_address   = optional(string)<br>    customer_address = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_connection"></a> [connection](#input\_connection) | (Required) The ID of the Direct Connect connection (or LAG) on which the new virtual interface will be provisioned. | `string` | n/a | yes |
| <a name="input_gateway"></a> [gateway](#input\_gateway) | (Required) The gateway configuration to connect to VPCs and Regions for this virtual interface. `gateway` as defined below.<br>    (Required) `type` - A gateway type for this virtual interface.<br>      - `DIRECT_CONNECT_GATEWAY`: Allow connections to multiple VPCs and Regions.<br>      - `VIRTUAL_PRIVATE_GATEWAY`: Allow connections to a single VPC in the same Region.<br>    (Required) `id` - The ID of the Direct Connect Gateway or Virtual Private Gateway to which to connect the virtual interface. | <pre>object({<br>    type = string<br>    id   = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the virtual interface assigned by the customer network. The name has a maximum of 100 characters. The following are valid characters: a-z, 0-9 and a hyphen (-). | `string` | n/a | yes |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | (Required) The Virtual Local Area Network number for the new virtual interface. Valid ranges are 1 - 4094. | `number` | n/a | yes |
| <a name="input_jumbo_frame_enabled"></a> [jumbo\_frame\_enabled](#input\_jumbo\_frame\_enabled) | (Optional) Whether to allow MTU size of `9001` on virtual interface. The MTU of a virtual private interface can be either `1500` or `9001` (jumbo frames). Defaults to `false`. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_router"></a> [router](#input\_router) | (Optional) The ID of the Router Type to get the sample router configuration. For example: `CiscoSystemsInc-2900SeriesRouters-IOS124` | `string` | `null` | no |
| <a name="input_sitelink_enabled"></a> [sitelink\_enabled](#input\_sitelink\_enabled) | (Optional) Indicate whether to enable SiteLink. Control direct connectivity between Direct Connect points of presence. Subject to additional charges. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the virtual interface. |
| <a name="output_aws_device"></a> [aws\_device](#output\_aws\_device) | The Direct Connect endpoint on which the virtual interface terminates. |
| <a name="output_bgp_peerings"></a> [bgp\_peerings](#output\_bgp\_peerings) | The configuration for BGP(Border Gateway Protocol) Peerings of the virtual interface.<br>    `address_family` - The address family for the BGP peer.<br>    `bgp_asn` - The Border Gateway Protocol (BGP) Autonomous System Number (ASN) of your on-premises router.<br>    `bgp_auth_key` - The password that will be used to authenticate the BGP session.<br>    `amazon_address` - The BGP peer IP configured on the AWS endpoint.<br>    `customer_address` - The BGP peer IP configured on your endpoint. |
| <a name="output_connection"></a> [connection](#output\_connection) | The ID of the Direct Connect connection. |
| <a name="output_gateway"></a> [gateway](#output\_gateway) | The ID of the Direct Connect connection. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the virtual interface. |
| <a name="output_jumbo_frame_capable"></a> [jumbo\_frame\_capable](#output\_jumbo\_frame\_capable) | Whether jumbo frames (9001 MTU) are supported. |
| <a name="output_jumbo_frame_enabled"></a> [jumbo\_frame\_enabled](#output\_jumbo\_frame\_enabled) | Whether jumbo frames (9001 MTU) are enabled. |
| <a name="output_mtu"></a> [mtu](#output\_mtu) | The MTU of the virtual interface. |
| <a name="output_name"></a> [name](#output\_name) | The name of the virtual interface. |
| <a name="output_sample_configuration"></a> [sample\_configuration](#output\_sample\_configuration) | The sample router configuration for the virtual interface. |
| <a name="output_sitelink_enabled"></a> [sitelink\_enabled](#output\_sitelink\_enabled) | Indicate whether to enable SiteLink. |
| <a name="output_vlan"></a> [vlan](#output\_vlan) | The ID of the VLAN. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
