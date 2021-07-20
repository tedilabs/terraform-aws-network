output "name" {
  description = "The VPC Endpoint Service name."
  value       = var.name
}

output "id" {
  description = "The ID of the VPC endpoint service."
  value       = aws_vpc_endpoint_service.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the VPC endpoint service."
  value       = aws_vpc_endpoint_service.this.arn
}

output "state" {
  description = "The state of the VPC endpoint service."
  value       = aws_vpc_endpoint_service.this.state
}

output "service_name" {
  description = "The service name."
  value       = aws_vpc_endpoint_service.this.service_name
}

output "service_type" {
  description = "The service type, `Gateway` or `Interface`."
  value       = aws_vpc_endpoint_service.this.service_type
}

output "gateway_load_balancer_arns" {
  description = "ARNs of Gateway Load Balancers which is associated to the endpoint service."
  value       = aws_vpc_endpoint_service.this.gateway_load_balancer_arns
}

output "network_load_balancer_arns" {
  description = "ARNs of Network Load Balancers which is associated to the endpoint service."
  value       = aws_vpc_endpoint_service.this.network_load_balancer_arns
}

output "availability_zones" {
  description = "The Availability Zones in which the service is available."
  value       = aws_vpc_endpoint_service.this.availability_zones
}

output "allowed_principals" {
  description = "A list of the ARNs of allowed principals to discover a VPC endpoint service."
  value       = var.allowed_principals
}

output "manages_vpc_endpoints" {
  description = "Whether or not the service manages its VPC endpoints"
  value       = aws_vpc_endpoint_service.this.manages_vpc_endpoints
}

output "base_domain_names" {
  description = "The DNS names for the service."
  value       = aws_vpc_endpoint_service.this.base_endpoint_dns_names
}

output "private_domain" {
  description = "The private DNS name for the service."
  value       = aws_vpc_endpoint_service.this.private_dns_name
}

output "private_domain_configurations" {
  description = "List of objects containing information about the endpoint service private DNS name configuration."
  value       = aws_vpc_endpoint_service.this.private_dns_name_configuration
}

output "notification_configurations" {
  description = "A list of Endpoint Connection Notifications for VPC Endpoint events."
  value       = var.notification_configurations
}
