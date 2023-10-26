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

output "name" {
  description = "The name of the network ACL."
  value       = var.name
}

output "vpc_id" {
  description = "The VPC ID of the network ACL."
  value       = aws_network_acl.this.vpc_id
}

output "subnets" {
  description = "A list of subnet IDs which is associated with the network ACL."
  value       = aws_network_acl.this.subnet_ids
}
