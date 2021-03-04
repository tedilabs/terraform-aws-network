# vpc-peering-requester

This module creates following resources.

- `aws_vpc_peering_connection`
- `aws_vpc_peering_connection_options` (optional)

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
| name | Desired name for the VPC Peering resources. | `string` | n/a | yes |
| accepter\_id | The AWS account ID of the owner of the peer VPC. | `string` | `""` | no |
| accepter\_region | The region of the VPC with which you are creating the VPC Peering Connection. | `string` | `""` | no |
| accepter\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection. | `string` | `""` | no |
| allow\_remote\_vpc\_dns\_resolution | Allow a requester VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the accepter VPC. This is not supported for inter-region VPC peering. | `bool` | `false` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| vpc\_id | The ID of the requester VPC. | `string` | `""` | no |

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
| status | The status of the VPC Peering Connection request. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
