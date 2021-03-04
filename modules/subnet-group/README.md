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
| terraform | >= 0.13 |
| aws | >= 3.30 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.30 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subnets | A map of subnet parameters to create subnets for the subnet group. | `map(map(any))` | n/a | yes |
| vpc\_id | The ID of the VPC which the subnet group belongs to. | `string` | n/a | yes |
| assign\_ipv6\_address\_on\_creation | Assign IPv6 address on subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch. | `bool` | `false` | no |
| cache\_subnet\_group\_enabled | Controls if Elasticache Subnet Group should be created. | `bool` | `false` | no |
| cache\_subnet\_group\_name | Desired name for the Elasticache Subnet Group. | `string` | `""` | no |
| customer\_owned\_ipv4\_pool | The customer owned IPv4 address pool. `outpost_arn` argument must be specified when configured. | `string` | `""` | no |
| dax\_subnet\_group\_enabled | Controls if DAX Subnet Group should be created. | `bool` | `false` | no |
| dax\_subnet\_group\_name | Desired name for the DAX Subnet Group. | `string` | `""` | no |
| db\_subnet\_group\_enabled | Controls if RDS Subnet Group should be created. | `bool` | `false` | no |
| db\_subnet\_group\_name | Desired name for the RDS Subnet Group. | `string` | `""` | no |
| dms\_replication\_subnet\_group\_enabled | Controls if DMS Replication Subnet Group should be created. | `bool` | `false` | no |
| dms\_replication\_subnet\_group\_name | Desired name for the DMS Replication Subnet Group. | `string` | `""` | no |
| docdb\_subnet\_group\_enabled | Controls if DocumentDB Subnet Group should be created. | `bool` | `false` | no |
| docdb\_subnet\_group\_name | Desired name for the DocumentDB Subnet Group. | `string` | `""` | no |
| map\_customer\_owned\_ip\_on\_launch | Should be true if network interfaces created in the subnet should be assigned a customer owned IP address. | `bool` | `false` | no |
| map\_public\_ip\_on\_launch | Should be false if you do not want to auto-assign public IP on launch. | `bool` | `false` | no |
| neptune\_subnet\_group\_enabled | Controls if Neptune Subnet Group should be created. | `bool` | `false` | no |
| neptune\_subnet\_group\_name | Desired name for the Neptune Subnet Group. | `string` | `""` | no |
| outpost\_arn | The ARN of the Outpost. | `string` | `""` | no |
| redshift\_subnet\_group\_enabled | Controls if Redshift Subnet Group should be created. | `bool` | `false` | no |
| redshift\_subnet\_group\_name | Desired name for the Redshift Subnet Group. | `string` | `""` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arns | A list of ARNs of subnets |
| availability\_zone\_ids | A list of availability zone IDs which the subnet group uses. |
| availability\_zones | A list of availability zones which the subnet group uses. |
| cache\_subnet\_group\_id | The ID of the Elasticache Subnet Group. |
| cidr\_blocks | The CIDR blocks of the subnet group. |
| dax\_subnet\_group\_id | The ID of the DAX Subnet Group. |
| db\_subnet\_group\_arn | The ARN of the RDS Subnet Group. |
| db\_subnet\_group\_id | The ID of the RDS Subnet Group. |
| dms\_replication\_subnet\_group\_id | The ID of the DMS Replication Subnet Group. |
| docdb\_subnet\_group\_arn | The ARN of the DocumentDB Subnet Group. |
| docdb\_subnet\_group\_id | The ID of the DocumentDB Subnet Group. |
| ids | A list of IDs of subnets |
| ipv6\_cidr\_blocks | The IPv6 CIDR blocks of the subnet group. |
| neptune\_subnet\_group\_arn | The ARN of the Neptune Subnet Group. |
| neptune\_subnet\_group\_id | The ID of the Neptune DB Subnet Group. |
| redshift\_subnet\_group\_arn | The ARN of the Redshift Subnet Group. |
| redshift\_subnet\_group\_id | The ID of the Redshift Subnet Group. |
| subnets | A list of subnets. |
| vpc\_id | The ID of the VPC which the subnet group belongs to. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
