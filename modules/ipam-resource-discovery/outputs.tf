output "id" {
  description = "The ID of the IPAM resource discovery."
  value       = aws_vpc_ipam_resource_discovery.this.id
}

output "arn" {
  description = "The ARN of the IPAM resource discovery."
  value       = aws_vpc_ipam_resource_discovery.this.arn
}

output "owner_id" {
  description = "The account ID for the account that manages the Resource Discovery."
  value       = aws_vpc_ipam_resource_discovery.this.owner_id
}

output "region" {
  description = "The home region of the Resource Discovery."
  value       = aws_vpc_ipam_resource_discovery.this.ipam_resource_discovery_region
}

output "name" {
  description = "The name of the IPAM resource discovery."
  value       = local.metadata.name
}

output "description" {
  description = "The description of the IPAM resource discovery."
  value       = aws_vpc_ipam_resource_discovery.this.description
}

output "operating_regions" {
  description = "A set of operating regions for the IPAM resource discovery."
  value       = aws_vpc_ipam_resource_discovery.this.operating_regions[*].region_name
}

output "is_default" {
  description = "Whether the resource discovery is the default. The default resource discovery is the resource discovery automatically created when you create an IPAM."
  value       = aws_vpc_ipam_resource_discovery.this.is_default
}

output "sharing" {
  description = <<EOF
  The configuration for sharing of the IPAM resource discovery resource discovery.
    `status` - An indication of whether the IPAM resource discovery resource discovery is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are `NOT_SHARED`, `SHARED_BY_ME` or `SHARED_WITH_ME`.
    `shares` - The list of resource shares via RAM (Resource Access Manager).
  EOF
  value = {
    status = length(module.share) > 0 ? "SHARED_BY_ME" : "NOT_SHARED"
    shares = module.share
  }
}
