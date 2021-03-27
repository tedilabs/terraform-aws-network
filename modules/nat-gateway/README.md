# nat-gateway

This module creates following resources.

- `aws_nat_gateway`
- `aws_eip` (optional)

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
| name | Desired name for the NAT Gateway resources. | `string` | n/a | yes |
| subnet\_id | The ID of the subnet which the NAT Gateway belongs to. | `string` | n/a | yes |
| assign\_eip\_on\_create | Assign a new Elastic IP to NAT Gateway on create. Set false if you want to provide existing Elastic IP. | `bool` | `false` | no |
| eip\_id | The Allocation ID of the Elastic IP address for the gateway. Create a new Elastic IP if not provided. | `string` | `""` | no |
| module\_tags\_enabled | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| resource\_group\_description | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| resource\_group\_enabled | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| resource\_group\_name | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| eip\_id | The Allocation ID of the Elastic IP address for the gateway. |
| eni\_id | The ENI ID of the network interface created by the NAT gateway. |
| id | The ID of the NAT Gateway. |
| private\_ip | The private IP address of the NAT Gateway. |
| public\_ip | The public IP address of the NAT Gateway. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
