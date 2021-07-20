# vpc-endpoint-service

This module creates following resources.

- `aws_vpc_endpoint_service`
- `aws_vpc_endpoint_service_allowed_principal` (optional)
- `aws_vpc_endpoint_connection_notification` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_vpc_endpoint_connection_notification.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_connection_notification) | resource |
| [aws_vpc_endpoint_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_vpc_endpoint_service_allowed_principal.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service_allowed_principal) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Desired name for the VPC Endpoint Service. | `string` | n/a | yes |
| <a name="input_acceptance_required"></a> [acceptance\_required](#input\_acceptance\_required) | Whether or not VPC endpoint connection requests to the service must be accepted by the service owner. | `bool` | `false` | no |
| <a name="input_allowed_principals"></a> [allowed\_principals](#input\_allowed\_principals) | A list of the ARNs of principal to allow to discover a VPC endpoint service. | `list(string)` | `[]` | no |
| <a name="input_gateway_load_balancer_arns"></a> [gateway\_load\_balancer\_arns](#input\_gateway\_load\_balancer\_arns) | List of Amazon Resource Names of one or more Gateway Load Balancers for the endpoint service. | `list(string)` | `null` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_network_load_balancer_arns"></a> [network\_load\_balancer\_arns](#input\_network\_load\_balancer\_arns) | List of Amazon Resource Names of one or more Network Load Balancers for the endpoint service. | `list(string)` | `null` | no |
| <a name="input_notification_configurations"></a> [notification\_configurations](#input\_notification\_configurations) | A list of configurations of Endpoint Connection Notifications for VPC Endpoint events. | <pre>list(object({<br>    sns_arn = string<br>    events  = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_private_domain"></a> [private\_domain](#input\_private\_domain) | The private domain name for the service. | `string` | `null` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allowed_principals"></a> [allowed\_principals](#output\_allowed\_principals) | A list of the ARNs of allowed principals to discover a VPC endpoint service. |
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the VPC endpoint service. |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The Availability Zones in which the service is available. |
| <a name="output_base_domain_names"></a> [base\_domain\_names](#output\_base\_domain\_names) | The DNS names for the service. |
| <a name="output_gateway_load_balancer_arns"></a> [gateway\_load\_balancer\_arns](#output\_gateway\_load\_balancer\_arns) | ARNs of Gateway Load Balancers which is associated to the endpoint service. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPC endpoint service. |
| <a name="output_manages_vpc_endpoints"></a> [manages\_vpc\_endpoints](#output\_manages\_vpc\_endpoints) | Whether or not the service manages its VPC endpoints |
| <a name="output_name"></a> [name](#output\_name) | The VPC Endpoint Service name. |
| <a name="output_network_load_balancer_arns"></a> [network\_load\_balancer\_arns](#output\_network\_load\_balancer\_arns) | ARNs of Network Load Balancers which is associated to the endpoint service. |
| <a name="output_notification_configurations"></a> [notification\_configurations](#output\_notification\_configurations) | A list of Endpoint Connection Notifications for VPC Endpoint events. |
| <a name="output_private_domain"></a> [private\_domain](#output\_private\_domain) | The private DNS name for the service. |
| <a name="output_private_domain_configurations"></a> [private\_domain\_configurations](#output\_private\_domain\_configurations) | List of objects containing information about the endpoint service private DNS name configuration. |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | The service name. |
| <a name="output_service_type"></a> [service\_type](#output\_service\_type) | The service type, `Gateway` or `Interface`. |
| <a name="output_state"></a> [state](#output\_state) | The state of the VPC endpoint service. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
