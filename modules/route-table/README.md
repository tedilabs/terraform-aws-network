# route-table

This module creates following resources.

- `aws_route_table`
- `aws_route` (optional)
- `aws_route_table_association` (optional)
- `aws_vpn_gateway_route_propagation` (optional)

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
| name | Desired name for the route table resources. | `string` | n/a | yes |
| vpc\_id | The ID of the VPC which the route table belongs to. | `string` | n/a | yes |
| gateways | A list of gateway IDs to associate with the route table. Only support Internet Gateway and Virtual Private Gateway. | `list(string)` | `[]` | no |
| ipv4\_routes | A list of IPv4 route rules. | `list(map(string))` | `[]` | no |
| ipv6\_routes | A list of IPv6 route rules. | `list(map(string))` | `[]` | no |
| module\_tags\_enabled | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| propagating\_vpn\_gateways | A list of Virtual Private Gateway IDs to propagate routes from. | `list(string)` | `[]` | no |
| resource\_group\_description | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| resource\_group\_enabled | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| resource\_group\_name | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| subnets | A list of subnet IDs to associate with the route table. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| associated\_gateways | A list of gateway IDs which is associated with the route table. |
| associated\_subnets | A list of subnet IDs which is associated with the route table. |
| id | The ID of the routing table. |
| propagated\_vpn\_gateways | A list of Virtual Private Gateway IDs which propagate routes from. |
| resource\_group\_enabled | Whether Resource Group is enabled. |
| resource\_group\_name | The name of Resource Group. |
| vpc\_id | The ID of the VPC which the route table belongs to. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
