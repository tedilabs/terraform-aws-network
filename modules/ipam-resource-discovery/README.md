# ipam-resource-discovery

Creates an IPAM resource discovery. A resource discovery is an IPAM component that enables IPAM to manage and monitor resources that belong to the owning account.

This module creates following resources.

- `aws_vpc_ipam_resource_discovery`

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
| <a name="module_share"></a> [share](#module\_share) | tedilabs/account/aws//modules/ram-share | ~> 0.24.0 |

## Resources

| Name | Type |
|------|------|
| [aws_vpc_ipam_resource_discovery.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_resource_discovery) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_regions.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the IPAM resource discovery. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the IPAM resource discovery. | `string` | `"Managed by Terraform."` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_operating_regions"></a> [operating\_regions](#input\_operating\_regions) | (Optional) A set of operating regions for the IPAM resource discovery. Operating Regions are AWS Regions where the IPAM is allowed to manage IP address CIDRs. IPAM only discovers and monitors resources in the AWS Regions you select as operating Regions. The current region is required to include. | `set(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_shares"></a> [shares](#input\_shares) | (Optional) A list of resource shares via RAM (Resource Access Manager). | <pre>list(object({<br>    name = optional(string)<br><br>    permissions = optional(set(string), ["AWSRAMPermissionIpamResourceDiscovery"])<br><br>    external_principals_allowed = optional(bool, false)<br>    principals                  = optional(set(string), [])<br><br>    tags = optional(map(string), {})<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the IPAM resource discovery. |
| <a name="output_description"></a> [description](#output\_description) | The description of the IPAM resource discovery. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IPAM resource discovery. |
| <a name="output_is_default"></a> [is\_default](#output\_is\_default) | Whether the resource discovery is the default. The default resource discovery is the resource discovery automatically created when you create an IPAM. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IPAM resource discovery. |
| <a name="output_operating_regions"></a> [operating\_regions](#output\_operating\_regions) | A set of operating regions for the IPAM resource discovery. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The account ID for the account that manages the Resource Discovery. |
| <a name="output_region"></a> [region](#output\_region) | The home region of the Resource Discovery. |
| <a name="output_sharing"></a> [sharing](#output\_sharing) | The configuration for sharing of the IPAM resource discovery resource discovery.<br>    `status` - An indication of whether the IPAM resource discovery resource discovery is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`.<br>    `shares` - The list of resource shares via RAM (Resource Access Manager). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
