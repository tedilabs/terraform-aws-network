# vpc

This module creates following resources.

- `aws_vpc`
- `aws_vpc_ipv4_cidr_block_association` (optional)
- `aws_route53_zone_association` (optional)
- `aws_vpc_dhcp_options` (optional)
- `aws_vpc_dhcp_options_association` (optional)
- `aws_internet_gateway` (optional)
- `aws_egress_only_internet_gateway` (optional)
- `aws_vpn_gateway` (optional)

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
| [aws_egress_only_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_route53_resolver_dnssec_config.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_dnssec_config) | resource |
| [aws_route53_zone_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_ipv4_cidr_block_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [aws_vpn_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Desired name for the VPC resources. | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_dhcp_options_domain_name"></a> [dhcp\_options\_domain\_name](#input\_dhcp\_options\_domain\_name) | Specifies DNS name for DHCP options set (requires enable\_dhcp\_options set to true). | `string` | `""` | no |
| <a name="input_dhcp_options_domain_name_servers"></a> [dhcp\_options\_domain\_name\_servers](#input\_dhcp\_options\_domain\_name\_servers) | Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable\_dhcp\_options set to true). | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| <a name="input_dhcp_options_enabled"></a> [dhcp\_options\_enabled](#input\_dhcp\_options\_enabled) | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type. | `bool` | `false` | no |
| <a name="input_dhcp_options_netbios_name_servers"></a> [dhcp\_options\_netbios\_name\_servers](#input\_dhcp\_options\_netbios\_name\_servers) | Specify a list of netbios servers for DHCP options set (requires enable\_dhcp\_options set to true). | `list(string)` | `[]` | no |
| <a name="input_dhcp_options_netbios_node_type"></a> [dhcp\_options\_netbios\_node\_type](#input\_dhcp\_options\_netbios\_node\_type) | Specify netbios node\_type for DHCP options set (requires enable\_dhcp\_options set to true). | `string` | `""` | no |
| <a name="input_dhcp_options_ntp_servers"></a> [dhcp\_options\_ntp\_servers](#input\_dhcp\_options\_ntp\_servers) | Specify a list of NTP servers for DHCP options set (requires enable\_dhcp\_options set to true). | `list(string)` | `[]` | no |
| <a name="input_dns_dnssec_validation_enabled"></a> [dns\_dnssec\_validation\_enabled](#input\_dns\_dnssec\_validation\_enabled) | Should be true to enable Route53 DNSSEC validation in the VPC. | `bool` | `false` | no |
| <a name="input_dns_hostnames_enabled"></a> [dns\_hostnames\_enabled](#input\_dns\_hostnames\_enabled) | Should be true to enable DNS hostnames in the VPC. | `bool` | `false` | no |
| <a name="input_dns_support_enabled"></a> [dns\_support\_enabled](#input\_dns\_support\_enabled) | Should be true to enable DNS support in the VPC. | `bool` | `true` | no |
| <a name="input_egress_only_internet_gateway_enabled"></a> [egress\_only\_internet\_gateway\_enabled](#input\_egress\_only\_internet\_gateway\_enabled) | Should be true if you want to create a new Egress Only Internet Gateway resource and attach it to the VPC. | `bool` | `false` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | A tenancy option for instances launched into the VPC. Only support `default` or `dedicated`. | `string` | `"default"` | no |
| <a name="input_internet_gateway_enabled"></a> [internet\_gateway\_enabled](#input\_internet\_gateway\_enabled) | Should be true if you want to create a new Internet Gateway resource and attach it to the VPC. | `bool` | `true` | no |
| <a name="input_ipv6_enabled"></a> [ipv6\_enabled](#input\_ipv6\_enabled) | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_private_hosted_zones"></a> [private\_hosted\_zones](#input\_private\_hosted\_zones) | List of private Hosted Zone IDs to associate. | `list(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_secondary_cidr_blocks"></a> [secondary\_cidr\_blocks](#input\_secondary\_cidr\_blocks) | List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpn_gateway_asn"></a> [vpn\_gateway\_asn](#input\_vpn\_gateway\_asn) | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN. | `string` | `"64512"` | no |
| <a name="input_vpn_gateway_enabled"></a> [vpn\_gateway\_enabled](#input\_vpn\_gateway\_enabled) | Should be true if you want to create a new VPN Gateway resource and attach it to the VPC. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the VPC. |
| <a name="output_cidr_block"></a> [cidr\_block](#output\_cidr\_block) | The CIDR block of the VPC. |
| <a name="output_default_network_acl_id"></a> [default\_network\_acl\_id](#output\_default\_network\_acl\_id) | The ID of the default network ACL. |
| <a name="output_default_route_table_id"></a> [default\_route\_table\_id](#output\_default\_route\_table\_id) | The ID of the default route table. |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation. |
| <a name="output_dhcp_options_arn"></a> [dhcp\_options\_arn](#output\_dhcp\_options\_arn) | The ARN of the DHCP Options Set. |
| <a name="output_dhcp_options_enabled"></a> [dhcp\_options\_enabled](#output\_dhcp\_options\_enabled) | Whether DHCP options set is enabled in the VPC. |
| <a name="output_dhcp_options_id"></a> [dhcp\_options\_id](#output\_dhcp\_options\_id) | The ID of the DHCP Options Set. |
| <a name="output_dns_dnssec_validation_enabled"></a> [dns\_dnssec\_validation\_enabled](#output\_dns\_dnssec\_validation\_enabled) | Whether or not the VPC has Route53 DNSSEC validation support. |
| <a name="output_dns_dnssec_validation_id"></a> [dns\_dnssec\_validation\_id](#output\_dns\_dnssec\_validation\_id) | The ID of a configuration for DNSSEC validation. |
| <a name="output_dns_hostnames_enabled"></a> [dns\_hostnames\_enabled](#output\_dns\_hostnames\_enabled) | Whether or not the VPC has DNS hostname support. |
| <a name="output_dns_support_enabled"></a> [dns\_support\_enabled](#output\_dns\_support\_enabled) | Whether or not the VPC has DNS support. |
| <a name="output_egress_only_internet_gateway_enabled"></a> [egress\_only\_internet\_gateway\_enabled](#output\_egress\_only\_internet\_gateway\_enabled) | Whether Egress Only Internet Gateway is enabled in the VPC. |
| <a name="output_egress_only_internet_gateway_id"></a> [egress\_only\_internet\_gateway\_id](#output\_egress\_only\_internet\_gateway\_id) | The ID of the Egress Only Internet Gateway. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPC. |
| <a name="output_instance_tenancy"></a> [instance\_tenancy](#output\_instance\_tenancy) | Tenancy of instances spin up within VPC. |
| <a name="output_internet_gateway_arn"></a> [internet\_gateway\_arn](#output\_internet\_gateway\_arn) | The ARN of the Internet Gateway. |
| <a name="output_internet_gateway_enabled"></a> [internet\_gateway\_enabled](#output\_internet\_gateway\_enabled) | Whether Internet Gateway is enabled in the VPC. |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway. |
| <a name="output_ipv6_association_id"></a> [ipv6\_association\_id](#output\_ipv6\_association\_id) | The association ID for the IPv6 CIDR block. |
| <a name="output_ipv6_cidr_block"></a> [ipv6\_cidr\_block](#output\_ipv6\_cidr\_block) | The IPv6 CIDR block. |
| <a name="output_main_route_table_id"></a> [main\_route\_table\_id](#output\_main\_route\_table\_id) | The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table. |
| <a name="output_name"></a> [name](#output\_name) | The VPC name. |
| <a name="output_private_hosted_zones"></a> [private\_hosted\_zones](#output\_private\_hosted\_zones) | List of associated private Hosted Zone IDs. |
| <a name="output_secondary_cidr_blocks"></a> [secondary\_cidr\_blocks](#output\_secondary\_cidr\_blocks) | List of secondary CIDR blocks of the VPC. |
| <a name="output_vpn_gateway_arn"></a> [vpn\_gateway\_arn](#output\_vpn\_gateway\_arn) | The ARN of the Virtual Private Gateway. |
| <a name="output_vpn_gateway_asn"></a> [vpn\_gateway\_asn](#output\_vpn\_gateway\_asn) | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN. |
| <a name="output_vpn_gateway_enabled"></a> [vpn\_gateway\_enabled](#output\_vpn\_gateway\_enabled) | Whether VPN Gateway is enabled in the VPC. |
| <a name="output_vpn_gateway_id"></a> [vpn\_gateway\_id](#output\_vpn\_gateway\_id) | The ID of the Virtual Private Gateway. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
