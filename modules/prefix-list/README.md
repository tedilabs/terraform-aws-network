# prefix-list

This module creates following resources.

- `aws_ec2_managed_prefix_list`
- `aws_ec2_managed_prefix_list_entry` (optional)

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
| [aws_ec2_managed_prefix_list.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_family"></a> [address\_family](#input\_address\_family) | (Required) Address family of this prefix list. Valid values are `IPv4` or `IPv6`. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the prefix list. The name must not start with `com.amazonaws`. | `string` | n/a | yes |
| <a name="input_entries"></a> [entries](#input\_entries) | (Optional) A set of prefix list entries. Each block of `entries` as defined below.<br>    (Required) `cidr` - The CIDR block of this entry.<br>    (Optional) `description` - The description of this entry. Due to API limitations, updating only the description of an existing entry requires temporarily removing and re-adding the entry. | <pre>set(object({<br>    cidr        = string<br>    description = optional(string, "Managed by Terraform.")<br>  }))</pre> | `[]` | no |
| <a name="input_max_entries"></a> [max\_entries](#input\_max\_entries) | (Optional) Maximum number of entries that this prefix list can contain. Configured the length of `entries` if not provided. | `number` | `null` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_shares"></a> [shares](#input\_shares) | (Optional) A list of resource shares via RAM (Resource Access Manager). | <pre>list(object({<br>    name = optional(string)<br><br>    permissions = optional(set(string), ["AWSRAMDefaultPermissionPrefixList"])<br><br>    external_principals_allowed = optional(bool, false)<br>    principals                  = optional(set(string), [])<br><br>    tags = optional(map(string), {})<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_family"></a> [address\_family](#output\_address\_family) | The address family of the prefix list. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the prefix list. |
| <a name="output_entries"></a> [entries](#output\_entries) | A set of prefix list entries. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the prefix list. |
| <a name="output_max_entries"></a> [max\_entries](#output\_max\_entries) | The maximum number of entries of this prefix list. |
| <a name="output_name"></a> [name](#output\_name) | The name of the prefix list. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The ID of the AWS account that owns this prefix list. |
| <a name="output_sharing"></a> [sharing](#output\_sharing) | The configuration for sharing of the VPC prefix list.<br>    `status` - An indication of whether the VPC prefix list is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`.<br>    `shares` - The list of resource shares via RAM (Resource Access Manager). |
| <a name="output_version"></a> [version](#output\_version) | Latest version of this prefix list. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
