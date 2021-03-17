output "name" {
  description = "The VPC Peering name."
  value       = var.name
}

output "id" {
  description = "The ID of the VPC Peering Connection."
  value       = aws_vpc_peering_connection.this.id
}

output "status" {
  description = "The status of the VPC Peering Connection request."
  value       = aws_vpc_peering_connection.this.accept_status
}

output "requester_id" {
  description = "The AWS account ID of the owner of the requester VPC."
  value       = local.requester.id
}

output "requester_region" {
  description = "The region of the requester VPC."
  value       = local.requester.region
}

output "requester_vpc_id" {
  description = "The ID of the requester VPC."
  value       = local.requester.vpc_id
}

output "accepter_id" {
  description = "The AWS account ID of the owner of the accepter VPC."
  value       = aws_vpc_peering_connection.this.peer_owner_id
}

output "accepter_region" {
  description = "The region of the accepter VPC."
  value       = aws_vpc_peering_connection.this.peer_region
}

output "accepter_vpc_id" {
  description = "The ID of the accepter VPC."
  value       = aws_vpc_peering_connection.this.peer_vpc_id
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
