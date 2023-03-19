output "id" {
  description = "The ID of the prefix list."
  value       = aws_ec2_managed_prefix_list.this.id
}

output "arn" {
  description = "The ARN of the prefix list."
  value       = aws_ec2_managed_prefix_list.this.arn
}

output "owner_id" {
  description = "The ID of the AWS account that owns this prefix list."
  value       = aws_ec2_managed_prefix_list.this.owner_id
}

output "name" {
  description = "The name of the prefix list."
  value       = aws_ec2_managed_prefix_list.this.name
}

output "address_family" {
  description = "The address family of the prefix list."
  value       = aws_ec2_managed_prefix_list.this.address_family
}

output "version" {
  description = "Latest version of this prefix list."
  value       = aws_ec2_managed_prefix_list.this.version
}

output "max_entries" {
  description = "The maximum number of entries of this prefix list."
  value       = aws_ec2_managed_prefix_list.this.max_entries
}

output "entries" {
  description = "A set of prefix list entries."
  value       = aws_ec2_managed_prefix_list.this.entry
}

output "sharing" {
  description = <<EOF
  The configuration for sharing of the VPC prefix list.
    `status` - An indication of whether the VPC prefix list is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`.
    `shares` - The list of resource shares via RAM (Resource Access Manager).
  EOF
  value = {
    status = length(module.share) > 0 ? "SHARED_BY_ME" : "NOT_SHARED"
    shares = module.share
  }
}
