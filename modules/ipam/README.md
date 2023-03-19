# ipam

This module creates following resources.

- `aws_vpc_ipam`
- `aws_vpc_ipam_scope` (optional)
- `aws_vpc_ipam_resource_discovery_association` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_vpc_ipam.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam) | resource |
| [aws_vpc_ipam_resource_discovery_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_resource_discovery_association) | resource |
| [aws_vpc_ipam_scope.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_scope) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_regions.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the IPAM. | `string` | n/a | yes |
| <a name="input_additional_private_scopes"></a> [additional\_private\_scopes](#input\_additional\_private\_scopes) | (Optional) A list of additional scopes to create and manage by the IPAM. A scope is the highest-level container within IPAM. When you create an IPAM, IPAM creates two default scopes for you. Each scope represents the IP space for a single network. Each block of `additional_scopes` as defined below.<br>    (Required) `name` - A name of the scope in the IPAM.<br>    (Optional) `description` - A description of the scope in the IPAM. | <pre>list(object({<br>    name        = string<br>    description = optional(string, "Managed by Terraform.")<br>  }))</pre> | `[]` | no |
| <a name="input_additional_resource_discovery_associations"></a> [additional\_resource\_discovery\_associations](#input\_additional\_resource\_discovery\_associations) | (Optional) A list of additional associations to an IPAM resource discovery with an Amazon VPC IPAM. A resource discovery is an IPAM component that enables IPAM to manage and monitor resources that belong to the owning account. Each block of `additional_resource_discovery_associations` as defined below.<br>    (Required) `resource_discovery` - The ID of the Resource Discovery to associate.<br>    (Optional) `tags` - A map of tags to add to the IPAM resource discovery association resource. | <pre>list(object({<br>    resource_discovery = string<br>    tags               = optional(map(string), {})<br>  }))</pre> | `[]` | no |
| <a name="input_cascade_deletion_enabled"></a> [cascade\_deletion\_enabled](#input\_cascade\_deletion\_enabled) | (Optional) Whether to enable you to quickly delete an IPAM, private scopes, pools in private scopes, and any allocations in the pools in private scopes. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the IPAM. | `string` | `"Managed by Terraform."` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_operating_regions"></a> [operating\_regions](#input\_operating\_regions) | (Optional) A set of operating regions for the IPAM. Operating Regions are AWS Regions where the IPAM is allowed to manage IP address CIDRs. IPAM only discovers and monitors resources in the AWS Regions you select as operating Regions. The current region is required to include. | `set(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_private_scopes"></a> [additional\_private\_scopes](#output\_additional\_private\_scopes) | The additional private scopes in the IPAM. You can create additional private scopes if you require support for multiple disconnected private networks. Additional private scopes allow you to create pools and manage resources that use the same IP space. You cannot create additional public scopes.<br>    `id` - The ID of the scope.<br>    `arn` - The Amazon Resource Name (ARN) of the scope.<br>    `name` - The name of the scope.<br>    `description` - The description of the scope.<br>    `type` - The type of the scope.<br>    `is_default` - Whether the scope is the default scope or not.<br>    `pool_count` - The number of pools in the scope. |
| <a name="output_additional_resource_discoveries"></a> [additional\_resource\_discoveries](#output\_additional\_resource\_discoveries) | The additional resource discoveries in the IPAM.<br>    `id` - The ID of resource discovery.<br>    `association_id` - The resource discovery association ID.<br>    `state` - The lifecycle state of the association when you associate or disassociate a resource discovery. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the IPAM. |
| <a name="output_default_resource_discovery"></a> [default\_resource\_discovery](#output\_default\_resource\_discovery) | The default resource discovery in the IPAM.<br>    `id` - The IPAM's default resource discovery ID.<br>    `association_id` - The IPAM's default resource discovery association ID. |
| <a name="output_default_scopes"></a> [default\_scopes](#output\_default\_scopes) | The default scopes in the IPAM. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: `public` and `private`. The `private` scope is intended for private IP space. The `public` scope is intended for all internet-routable IP space.<br>    `private` - The ID of the IPAM's private scope.<br>    `public` - The ID of the IPAM's public scope. |
| <a name="output_description"></a> [description](#output\_description) | The description of the IPAM. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IPAM. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IPAM. |
| <a name="output_operating_regions"></a> [operating\_regions](#output\_operating\_regions) | A set of operating regions for the IPAM. |
| <a name="output_scope_count"></a> [scope\_count](#output\_scope\_count) | The number of scopes in the IPAM. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
