output "id" {
  description = "The ID of the network ACL."
  value       = aws_network_acl.this.id
}

output "arn" {
  description = "The ARN of the network ACL."
  value       = aws_network_acl.this.arn
}

output "owner_id" {
  description = "The ID of the AWS account that owns the network ACL."
  value       = aws_network_acl.this.owner_id
}

output "associated_subnets" {
  description = "A list of subnet IDs which is associated with the network ACL."
  value       = var.subnets
}


###################################################
# Resource Group
###################################################

output "resource_group_enabled" {
  description = "Whether Resource Group is enabled."
  value       = var.resource_group_enabled
}

output "resource_group_name" {
  description = "The name of Resource Group."
  value       = try(aws_resourcegroups_group.this.*.name[0], null)
}
