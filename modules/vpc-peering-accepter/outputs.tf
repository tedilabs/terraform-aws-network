output "name" {
  description = "The VPC Peering name."
  value       = var.name
}

output "id" {
  description = "The ID of the VPC Peering Connection."
  value       = aws_vpc_peering_connection_accepter.this.id
}

output "status" {
  description = "The status of the VPC Peering Connection request."
  value       = aws_vpc_peering_connection_accepter.this.accept_status
}

output "requester" {
  description = "The requester information including AWS Account ID, Region, VPC ID."
  value       = local.requester
}

output "accepter" {
  description = "The accepter information including AWS Account ID, Region, VPC ID."
  value       = local.accepter
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
