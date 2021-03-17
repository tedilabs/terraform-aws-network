output "vpc_id" {
  description = "The ID of the VPC which the route table belongs to."
  value       = var.vpc_id
}

output "id" {
  description = "The ID of the routing table."
  value       = aws_route_table.this.id
}

output "associated_subnets" {
  description = "A list of subnet IDs which is associated with the route table."
  value       = aws_route_table_association.subnets[*].subnet_id
}

output "associated_gateways" {
  description = "A list of gateway IDs which is associated with the route table."
  value       = values(aws_route_table_association.gateways)[*].gateway_id
}

output "propagated_vpn_gateways" {
  description = "A list of Virtual Private Gateway IDs which propagate routes from."
  value       = values(aws_vpn_gateway_route_propagation.this)[*].vpn_gateway_id
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
