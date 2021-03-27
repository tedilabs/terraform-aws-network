output "id" {
  description = "The ID of the security group."
  value       = aws_security_group.this.id
}

output "arn" {
  description = "The ARN of the security group."
  value       = aws_security_group.this.arn
}

output "name" {
  description = "The name of the security group."
  value       = aws_security_group.this.name
}

output "owner_id" {
  description = "The ID of the AWS account that owns the security group."
  value       = aws_security_group.this.owner_id
}

output "vpc_id" {
  description = "The ID of the associated VPC."
  value       = aws_security_group.this.vpc_id
}
