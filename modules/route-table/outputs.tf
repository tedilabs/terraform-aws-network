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

output "associated_vpc_gateway_endpoints" {
  description = "A list of the VPC Gateway Endpoint IDs which is associated with the route table."
  value       = var.vpc_gateway_endpoints
}

output "propagated_vpn_gateways" {
  description = "A list of Virtual Private Gateway IDs which propagate routes from."
  value       = values(aws_vpn_gateway_route_propagation.this)[*].vpn_gateway_id
}

output "is_main" {
  description = "Whether to set this route table as the main route table."
  value       = var.is_main
}
