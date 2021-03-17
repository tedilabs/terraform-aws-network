# vpc-peering-accepter

This module creates following resources.

- `aws_vpc_peering_connection_accepter`
- `aws_vpc_peering_connection_options`

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
| id | The VPC Peering Connection ID to manage. | `string` | n/a | yes |
| allow\_remote\_vpc\_dns\_resolution | Allow a accepter VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requester VPC. This is not supported for inter-region VPC peering. | `bool` | `false` | no |
| module\_tags\_enabled | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| name | Desired name for the VPC Peering resources. | `string` | `""` | no |
| resource\_group\_description | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| resource\_group\_enabled | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| resource\_group\_name | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| accepter\_id | The AWS account ID of the owner of the accepter VPC. |
| accepter\_region | The region of the accepter VPC. |
| accepter\_vpc\_id | The ID of the accepter VPC. |
| id | The ID of the VPC Peering Connection. |
| name | The VPC Peering name. |
| requester\_id | The AWS account ID of the owner of the requester VPC. |
| requester\_region | The region of the requester VPC. |
| requester\_vpc\_id | The ID of the requester VPC. |
| resource\_group\_enabled | Whether Resource Group is enabled. |
| resource\_group\_name | The name of Resource Group. |
| status | The status of the VPC Peering Connection request. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
