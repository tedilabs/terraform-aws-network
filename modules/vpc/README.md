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
| terraform | >= 0.13 |
| aws | >= 3.30 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.30 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Desired name for the VPC resources. | `string` | n/a | yes |
| cidr\_block | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden. | `string` | `"0.0.0.0/0"` | no |
| dhcp\_options\_domain\_name | Specifies DNS name for DHCP options set (requires enable\_dhcp\_options set to true). | `string` | `""` | no |
| dhcp\_options\_domain\_name\_servers | Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable\_dhcp\_options set to true). | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| dhcp\_options\_enabled | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type. | `bool` | `false` | no |
| dhcp\_options\_netbios\_name\_servers | Specify a list of netbios servers for DHCP options set (requires enable\_dhcp\_options set to true). | `list(string)` | `[]` | no |
| dhcp\_options\_netbios\_node\_type | Specify netbios node\_type for DHCP options set (requires enable\_dhcp\_options set to true). | `string` | `""` | no |
| dhcp\_options\_ntp\_servers | Specify a list of NTP servers for DHCP options set (requires enable\_dhcp\_options set to true). | `list(string)` | `[]` | no |
| dns\_hostnames\_enabled | Should be true to enable DNS hostnames in the VPC. | `bool` | `false` | no |
| dns\_support\_enabled | Should be true to enable DNS support in the VPC. | `bool` | `true` | no |
| egress\_only\_internet\_gateway\_enabled | Should be true if you want to create a new Egress Only Internet Gateway resource and attach it to the VPC. | `bool` | `false` | no |
| instance\_tenancy | A tenancy option for instances launched into the VPC. Only support `default` or `dedicated`. | `string` | `"default"` | no |
| internet\_gateway\_enabled | Should be true if you want to create a new Internet Gateway resource and attach it to the VPC. | `bool` | `true` | no |
| ipv6\_enabled | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. | `bool` | `false` | no |
| module\_tags\_enabled | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| private\_hosted\_zones | List of private Hosted Zone IDs to associate. | `list(string)` | `[]` | no |
| resource\_group\_description | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| resource\_group\_enabled | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| resource\_group\_name | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| secondary\_cidr\_blocks | List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| vpn\_gateway\_asn | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN. | `string` | `"64512"` | no |
| vpn\_gateway\_enabled | Should be true if you want to create a new VPN Gateway resource and attach it to the VPC. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the VPC. |
| cidr\_block | The CIDR block of the VPC. |
| default\_network\_acl\_id | The ID of the default network ACL. |
| default\_route\_table\_id | The ID of the default route table. |
| default\_security\_group\_id | The ID of the security group created by default on VPC creation. |
| dhcp\_options\_arn | The ARN of the DHCP Options Set. |
| dhcp\_options\_enabled | Whether DHCP options set is enabled in the VPC. |
| dhcp\_options\_id | The ID of the DHCP Options Set. |
| dns\_hostnames\_enabled | Whether or not the VPC has DNS hostname support. |
| dns\_support\_enabled | Whether or not the VPC has DNS support. |
| egress\_only\_internet\_gateway\_enabled | Whether Egress Only Internet Gateway is enabled in the VPC. |
| egress\_only\_internet\_gateway\_id | The ID of the Egress Only Internet Gateway. |
| id | The ID of the VPC. |
| instance\_tenancy | Tenancy of instances spin up within VPC. |
| internet\_gateway\_arn | The ARN of the Internet Gateway. |
| internet\_gateway\_enabled | Whether Internet Gateway is enabled in the VPC. |
| internet\_gateway\_id | The ID of the Internet Gateway. |
| ipv6\_association\_id | The association ID for the IPv6 CIDR block. |
| ipv6\_cidr\_block | The IPv6 CIDR block. |
| main\_route\_table\_id | The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table. |
| name | The VPC name. |
| private\_hosted\_zones | List of associated private Hosted Zone IDs. |
| resource\_group\_enabled | Whether Resource Group is enabled. |
| resource\_group\_name | The name of Resource Group. |
| secondary\_cidr\_blocks | List of secondary CIDR blocks of the VPC. |
| vpn\_gateway\_arn | The ARN of the Virtual Private Gateway. |
| vpn\_gateway\_asn | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN. |
| vpn\_gateway\_enabled | Whether VPN Gateway is enabled in the VPC. |
| vpn\_gateway\_id | The ID of the Virtual Private Gateway. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
