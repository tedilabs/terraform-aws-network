output "name" {
  description = "The VPC Interface Endpoint name."
  value       = var.name
}

output "service_name" {
  description = "The service name of the VPC Interface Endpoint."
  value       = aws_vpc_endpoint.this.service_name
}

output "id" {
  description = "The ID of the VPC endpoint."
  value       = aws_vpc_endpoint.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the VPC endpoint."
  value       = aws_vpc_endpoint.this.arn
}

output "state" {
  description = "The state of the VPC endpoint."
  value       = aws_vpc_endpoint.this.state
}

output "owner_id" {
  description = "The Owner ID of the VPC endpoint."
  value       = aws_vpc_endpoint.this.owner_id
}

output "managed" {
  description = "Whether or not the VPC Endpoint is being managed by its service."
  value       = aws_vpc_endpoint.this.requester_managed
}

output "vpc_id" {
  description = "The VPC ID of the VPC endpoint."
  value       = aws_vpc_endpoint.this.vpc_id
}

output "subnet_ids" {
  description = "A list of Subnet IDs of the VPC endpoint."
  value       = var.subnets
}

output "network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint."
  value       = aws_vpc_endpoint.this.network_interface_ids
}

output "dns_configurations" {
  description = "The DNS entries for the VPC Endpoint."
  value       = aws_vpc_endpoint.this.dns_entry
}

output "policy" {
  description = "The policy which is attached to the endpoint that controls access to the service."
  value       = aws_vpc_endpoint.this.policy
}

output "notification_configurations" {
  description = "A list of Endpoint Connection Notifications for VPC Endpoint events."
  value       = var.notification_configurations
}
