output "name" {
  description = "The VPC Gateway Endpoint name."
  value       = var.name
}

output "service_name" {
  description = "The service name of the VPC Gateway Endpoint."
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

output "cidr_blocks" {
  description = "The list of CIDR blocks for the exposed AWS service."
  value       = aws_vpc_endpoint.this.cidr_blocks
}

output "prefix_list_id" {
  description = "The prefix list ID of the exposed AWS service."
  value       = aws_vpc_endpoint.this.prefix_list_id
}

output "policy" {
  description = "The policy which is attached to the endpoint that controls access to the service."
  value       = aws_vpc_endpoint.this.policy
}

output "notification_configurations" {
  description = "A list of Endpoint Connection Notifications for VPC Endpoint events."
  value       = var.notification_configurations
}
