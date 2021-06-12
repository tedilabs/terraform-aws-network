# vpc-peering-accepter

This module creates following resources.

- `aws_vpc_peering_connection_accepter`
- `aws_vpc_peering_connection_options`

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
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_vpc_peering_connection_accepter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_vpc_peering_connection_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_peering_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_id"></a> [id](#input\_id) | The VPC Peering Connection ID to manage. | `string` | n/a | yes |
| <a name="input_allow_remote_vpc_dns_resolution"></a> [allow\_remote\_vpc\_dns\_resolution](#input\_allow\_remote\_vpc\_dns\_resolution) | Allow a accepter VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requester VPC. This is not supported for inter-region VPC peering. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Desired name for the VPC Peering resources. | `string` | `""` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accepter"></a> [accepter](#output\_accepter) | The accepter information including AWS Account ID, Region, VPC ID. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPC Peering Connection. |
| <a name="output_name"></a> [name](#output\_name) | The VPC Peering name. |
| <a name="output_requester"></a> [requester](#output\_requester) | The requester information including AWS Account ID, Region, VPC ID. |
| <a name="output_status"></a> [status](#output\_status) | The status of the VPC Peering Connection request. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
