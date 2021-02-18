# nat-gateway

This module creates following resources.

- `aws_nat_gateway`
- `aws_eip` (optional)

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
| name | Desired name for the NAT Gateway resources. | `string` | n/a | yes |
| subnet\_id | The ID of the subnet which the NAT Gateway belongs to. | `string` | n/a | yes |
| eip\_id | The Allocation ID of the Elastic IP address for the gateway. Create a new Elastic IP if not provided. | `string` | `""` | no |
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
