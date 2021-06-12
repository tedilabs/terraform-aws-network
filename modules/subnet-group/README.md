# subnet-group

This module creates following resources.

- `aws_subnet`
- `aws_db_subnet_group` (optional)
- `aws_elasticache_subnet_group` (optional)
- `aws_redshift_subnet_group` (optional)
- `aws_neptune_subnet_group` (optional)
- `aws_docdb_subnet_group` (optional)
- `aws_dax_subnet_group` (optional)
- `aws_dms_replication_subnet_group` (optional)

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
| [aws_dax_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_subnet_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_dms_replication_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_subnet_group) | resource |
| [aws_docdb_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_neptune_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_subnet_group) | resource |
| [aws_redshift_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the subnet group. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A map of subnet parameters to create subnets for the subnet group. | `map(map(any))` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC which the subnet group belongs to. | `string` | n/a | yes |
| <a name="input_assign_ipv6_address_on_creation"></a> [assign\_ipv6\_address\_on\_creation](#input\_assign\_ipv6\_address\_on\_creation) | Assign IPv6 address on subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch. | `bool` | `false` | no |
| <a name="input_cache_subnet_group_enabled"></a> [cache\_subnet\_group\_enabled](#input\_cache\_subnet\_group\_enabled) | Controls if Elasticache Subnet Group should be created. | `bool` | `false` | no |
| <a name="input_cache_subnet_group_name"></a> [cache\_subnet\_group\_name](#input\_cache\_subnet\_group\_name) | Desired name for the Elasticache Subnet Group. | `string` | `""` | no |
| <a name="input_customer_owned_ipv4_pool"></a> [customer\_owned\_ipv4\_pool](#input\_customer\_owned\_ipv4\_pool) | The customer owned IPv4 address pool. `outpost_arn` argument must be specified when configured. | `string` | `""` | no |
| <a name="input_dax_subnet_group_enabled"></a> [dax\_subnet\_group\_enabled](#input\_dax\_subnet\_group\_enabled) | Controls if DAX Subnet Group should be created. | `bool` | `false` | no |
| <a name="input_dax_subnet_group_name"></a> [dax\_subnet\_group\_name](#input\_dax\_subnet\_group\_name) | Desired name for the DAX Subnet Group. | `string` | `""` | no |
| <a name="input_db_subnet_group_enabled"></a> [db\_subnet\_group\_enabled](#input\_db\_subnet\_group\_enabled) | Controls if RDS Subnet Group should be created. | `bool` | `false` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Desired name for the RDS Subnet Group. | `string` | `""` | no |
| <a name="input_dms_replication_subnet_group_enabled"></a> [dms\_replication\_subnet\_group\_enabled](#input\_dms\_replication\_subnet\_group\_enabled) | Controls if DMS Replication Subnet Group should be created. | `bool` | `false` | no |
| <a name="input_dms_replication_subnet_group_name"></a> [dms\_replication\_subnet\_group\_name](#input\_dms\_replication\_subnet\_group\_name) | Desired name for the DMS Replication Subnet Group. | `string` | `""` | no |
| <a name="input_docdb_subnet_group_enabled"></a> [docdb\_subnet\_group\_enabled](#input\_docdb\_subnet\_group\_enabled) | Controls if DocumentDB Subnet Group should be created. | `bool` | `false` | no |
| <a name="input_docdb_subnet_group_name"></a> [docdb\_subnet\_group\_name](#input\_docdb\_subnet\_group\_name) | Desired name for the DocumentDB Subnet Group. | `string` | `""` | no |
| <a name="input_map_customer_owned_ip_on_launch"></a> [map\_customer\_owned\_ip\_on\_launch](#input\_map\_customer\_owned\_ip\_on\_launch) | Should be true if network interfaces created in the subnet should be assigned a customer owned IP address. | `bool` | `false` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Should be false if you do not want to auto-assign public IP on launch. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_neptune_subnet_group_enabled"></a> [neptune\_subnet\_group\_enabled](#input\_neptune\_subnet\_group\_enabled) | Controls if Neptune Subnet Group should be created. | `bool` | `false` | no |
| <a name="input_neptune_subnet_group_name"></a> [neptune\_subnet\_group\_name](#input\_neptune\_subnet\_group\_name) | Desired name for the Neptune Subnet Group. | `string` | `""` | no |
| <a name="input_outpost_arn"></a> [outpost\_arn](#input\_outpost\_arn) | The ARN of the Outpost. | `string` | `""` | no |
| <a name="input_redshift_subnet_group_enabled"></a> [redshift\_subnet\_group\_enabled](#input\_redshift\_subnet\_group\_enabled) | Controls if Redshift Subnet Group should be created. | `bool` | `false` | no |
| <a name="input_redshift_subnet_group_name"></a> [redshift\_subnet\_group\_name](#input\_redshift\_subnet\_group\_name) | Desired name for the Redshift Subnet Group. | `string` | `""` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arns"></a> [arns](#output\_arns) | A list of ARNs of subnets |
| <a name="output_availability_zone_ids"></a> [availability\_zone\_ids](#output\_availability\_zone\_ids) | A list of availability zone IDs which the subnet group uses. |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | A list of availability zones which the subnet group uses. |
| <a name="output_cache_subnet_group_id"></a> [cache\_subnet\_group\_id](#output\_cache\_subnet\_group\_id) | The ID of the Elasticache Subnet Group. |
| <a name="output_cidr_blocks"></a> [cidr\_blocks](#output\_cidr\_blocks) | The CIDR blocks of the subnet group. |
| <a name="output_dax_subnet_group_id"></a> [dax\_subnet\_group\_id](#output\_dax\_subnet\_group\_id) | The ID of the DAX Subnet Group. |
| <a name="output_db_subnet_group_arn"></a> [db\_subnet\_group\_arn](#output\_db\_subnet\_group\_arn) | The ARN of the RDS Subnet Group. |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | The ID of the RDS Subnet Group. |
| <a name="output_dms_replication_subnet_group_id"></a> [dms\_replication\_subnet\_group\_id](#output\_dms\_replication\_subnet\_group\_id) | The ID of the DMS Replication Subnet Group. |
| <a name="output_docdb_subnet_group_arn"></a> [docdb\_subnet\_group\_arn](#output\_docdb\_subnet\_group\_arn) | The ARN of the DocumentDB Subnet Group. |
| <a name="output_docdb_subnet_group_id"></a> [docdb\_subnet\_group\_id](#output\_docdb\_subnet\_group\_id) | The ID of the DocumentDB Subnet Group. |
| <a name="output_ids"></a> [ids](#output\_ids) | A list of IDs of subnets |
| <a name="output_ipv6_cidr_blocks"></a> [ipv6\_cidr\_blocks](#output\_ipv6\_cidr\_blocks) | The IPv6 CIDR blocks of the subnet group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the subnet group. |
| <a name="output_neptune_subnet_group_arn"></a> [neptune\_subnet\_group\_arn](#output\_neptune\_subnet\_group\_arn) | The ARN of the Neptune Subnet Group. |
| <a name="output_neptune_subnet_group_id"></a> [neptune\_subnet\_group\_id](#output\_neptune\_subnet\_group\_id) | The ID of the Neptune DB Subnet Group. |
| <a name="output_redshift_subnet_group_arn"></a> [redshift\_subnet\_group\_arn](#output\_redshift\_subnet\_group\_arn) | The ARN of the Redshift Subnet Group. |
| <a name="output_redshift_subnet_group_id"></a> [redshift\_subnet\_group\_id](#output\_redshift\_subnet\_group\_id) | The ID of the Redshift Subnet Group. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A list of subnets. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC which the subnet group belongs to. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
