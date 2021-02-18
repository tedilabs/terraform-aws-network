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
| aws | >= 3.27 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.27 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Desired name for the route table resources. | `string` | n/a | yes |
| vpc\_id | The ID of the VPC which the route table belongs to. | `string` | n/a | yes |
| gateways | A list of gateway IDs to associate with the route table. Only support Internet Gateway and Virtual Private Gateway. | `list(string)` | `[]` | no |
| ipv4\_routes | A list of IPv4 route rules. | `list(map(string))` | `[]` | no |
| ipv6\_routes | A list of IPv6 route rules. | `list(map(string))` | `[]` | no |
| propagating\_vpn\_gateways | A list of Virtual Private Gateway IDs to propagate routes from. | `list(string)` | `[]` | no |
| subnets | A list of subnet IDs to associate with the route table. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| associated\_gateways | A list of gateway IDs which is associated with the route table. |
| associated\_subnets | A list of subnet IDs which is associated with the route table. |
| id | The ID of the routing table. |
| propagated\_vpn\_gateways | A list of Virtual Private Gateway IDs which propagate routes from. |
| vpc\_id | The ID of the VPC which the route table belongs to. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
