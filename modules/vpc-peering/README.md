# vpc-peering

This module creates following resources.

- `aws_vpc_peering_connection`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.34 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.34 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| accepter\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection. | `string` | n/a | yes |
| name | Desired name for the VPC Peering resources. | `string` | n/a | yes |
| requester\_vpc\_id | The ID of the requester VPC. | `string` | n/a | yes |
| accepter\_allow\_remote\_vpc\_dns\_resolution | Allow a accepter VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requester VPC. This is not supported for inter-region VPC peering. | `bool` | `false` | no |
| module\_tags\_enabled | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| requester\_allow\_remote\_vpc\_dns\_resolution | Allow a requester VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the accepter VPC. This is not supported for inter-region VPC peering. | `bool` | `false` | no |
| resource\_group\_description | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| resource\_group\_enabled | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| resource\_group\_name | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| accepter | The accepter information including AWS Account ID, Region, VPC ID. |
| id | The ID of the VPC Peering Connection. |
| name | The VPC Peering name. |
| requester | The requester information including AWS Account ID, Region, VPC ID. |
| status | The status of the VPC Peering Connection request. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
