# reachability-analyzer-path

This module creates following resources.

- `aws_ec2_network_insights_path`
- `aws_ec2_network_insights_analysis` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_network_insights_analysis.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_network_insights_analysis) | resource |
| [aws_ec2_network_insights_path.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_network_insights_path) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_network"></a> [destination\_network](#input\_destination\_network) | (Required) The configuration of destination network for analysis. `destination_network` as defined below.<br>    (Required) `id` - The ID of resource which is the destination of the path. Can be an Instance, Internet Gateway, Network Interface, Transit Gateway, VPC Endpoint, VPC Peering Connection or VPN Gateway.<br>    (Optional) `ip_address` - The IP address of the destination resource.<br>    (Optional) `port` - The port number of destination to analyze access to. | <pre>object({<br>    id         = string<br>    ip_address = optional(string)<br>    port       = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the reachability analyzer path. | `string` | n/a | yes |
| <a name="input_source_network"></a> [source\_network](#input\_source\_network) | (Required) The configuration of source network for analysis. `source_network` as defined below.<br>    (Required) `id` - The ID of resource which is the source of the path. Can be an Instance, Internet Gateway, Network Interface, Transit Gateway, VPC Endpoint, VPC Peering Connection or VPN Gateway.<br>    (Optional) `ip_address` - The IP address of the source resource. | <pre>object({<br>    id         = string<br>    ip_address = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_analyses"></a> [analyses](#input\_analyses) | (Optional) The configuration of analyses to run with the reachability analyzer path. Each block of `analyses` as defined below.<br>    (Required) `name` - A name of the analysis with the reachability analyzer path.<br>    (Optional) `required_intermediate_components` - A list of ARNs for resources the path must traverse. Intermediate components include load balancers, NAT gateways, and peering connections. You cannot use security groups, network access control lists, network interfaces, or route tables as intermediate components.<br>    (Optional) `wait_for_completion` - Whether to wait for the analysis status to change to `succeeded` or `failed`. Setting this to `false` will skip the process. Defaults to `true`. | <pre>list(object({<br>    name = string<br><br>    required_intermediate_components = optional(list(string), [])<br>    wait_for_completion              = optional(bool, true)<br>  }))</pre> | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol to use for analysis. Valid values are `TCP` or `UDP`. | `string` | `"TCP"` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_analyses"></a> [analyses](#output\_analyses) | A list of histories of the analysis with the reachability analyzer path. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the reachability analyzer path. |
| <a name="output_destination_network"></a> [destination\_network](#output\_destination\_network) | The configuration of destination network for analysis. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the reachability analyzer path. |
| <a name="output_name"></a> [name](#output\_name) | The name of the reachability analyzer path. |
| <a name="output_protocol"></a> [protocol](#output\_protocol) | The protocol to use for analysis. |
| <a name="output_source_network"></a> [source\_network](#output\_source\_network) | The configuration of source network for analysis. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
