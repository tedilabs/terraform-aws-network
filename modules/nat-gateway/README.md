# nat-gateway

This module creates following resources.

- `aws_nat_gateway`
- `aws_eip` (optional)

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
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Desired name for the NAT Gateway resources. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet which the NAT Gateway belongs to. | `string` | n/a | yes |
| <a name="input_assign_eip_on_create"></a> [assign\_eip\_on\_create](#input\_assign\_eip\_on\_create) | Assign a new Elastic IP to NAT Gateway on create. Set false if you want to provide existing Elastic IP. | `bool` | `false` | no |
| <a name="input_eip_id"></a> [eip\_id](#input\_eip\_id) | The Allocation ID of the Elastic IP address for the gateway. Create a new Elastic IP if not provided. | `string` | `""` | no |
| <a name="input_is_private"></a> [is\_private](#input\_is\_private) | Whether to create the gateway as private or public connectivity type. Defaults to public(false). | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connectivity_type"></a> [connectivity\_type](#output\_connectivity\_type) | Connectivity type for the gateway. Valid values are private and public. |
| <a name="output_eip_id"></a> [eip\_id](#output\_eip\_id) | The Allocation ID of the Elastic IP address for the gateway. |
| <a name="output_eni_id"></a> [eni\_id](#output\_eni\_id) | The ENI ID of the network interface created by the NAT gateway. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the NAT Gateway. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP address of the NAT Gateway. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP address of the NAT Gateway. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
