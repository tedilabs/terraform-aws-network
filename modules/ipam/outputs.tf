output "id" {
  description = "The ID of the IPAM."
  value       = aws_vpc_ipam.this.id
}

output "arn" {
  description = "The ARN of the IPAM."
  value       = aws_vpc_ipam.this.arn
}

output "name" {
  description = "The name of the IPAM."
  value       = local.metadata.name
}

output "description" {
  description = "The description of the IPAM."
  value       = aws_vpc_ipam.this.description
}

output "operating_regions" {
  description = "A set of operating regions for the IPAM."
  value       = aws_vpc_ipam.this.operating_regions[*].region_name
}

output "scope_count" {
  description = "The number of scopes in the IPAM."
  value       = aws_vpc_ipam.this.scope_count
}

output "default_scopes" {
  description = <<EOF
  The default scopes in the IPAM. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: `public` and `private`. The `private` scope is intended for private IP space. The `public` scope is intended for all internet-routable IP space.
    `private` - The ID of the IPAM's private scope.
    `public` - The ID of the IPAM's public scope.
  EOF
  value = {
    private = aws_vpc_ipam.this.private_default_scope_id
    public  = aws_vpc_ipam.this.public_default_scope_id
  }
}

output "additional_private_scopes" {
  description = <<EOF
  The additional private scopes in the IPAM. You can create additional private scopes if you require support for multiple disconnected private networks. Additional private scopes allow you to create pools and manage resources that use the same IP space. You cannot create additional public scopes.
    `id` - The ID of the scope.
    `arn` - The Amazon Resource Name (ARN) of the scope.
    `name` - The name of the scope.
    `description` - The description of the scope.
    `type` - The type of the scope.
    `is_default` - Whether the scope is the default scope or not.
    `pool_count` - The number of pools in the scope.
  EOF
  value = {
    for name, scope in aws_vpc_ipam_scope.this :
    name => {
      id          = scope.id
      arn         = scope.arn
      name        = name
      description = scope.description
      type        = scope.ipam_scope_type
      is_default  = scope.is_default
      pool_count  = scope.pool_count
    }
  }
}

output "default_resource_discovery" {
  description = <<EOF
  The default resource discovery in the IPAM.
    `id` - The IPAM's default resource discovery ID.
    `association_id` - The IPAM's default resource discovery association ID.
  EOF
  value = {
    id             = aws_vpc_ipam.this.default_resource_discovery_id
    association_id = aws_vpc_ipam.this.default_resource_discovery_association_id
  }
}

output "additional_resource_discoveries" {
  description = <<EOF
  The additional resource discoveries in the IPAM.
    `id` - The ID of resource discovery.
    `association_id` - The resource discovery association ID.
    `state` - The lifecycle state of the association when you associate or disassociate a resource discovery.
  EOF
  value = [
    for association in aws_vpc_ipam_resource_discovery_association.this : {
      id             = association.ipam_resource_discovery_id
      association_id = association.id
      state          = association.state
    }
  ]
}
