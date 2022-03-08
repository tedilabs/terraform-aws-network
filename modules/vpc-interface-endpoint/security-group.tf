###################################################
# Security Group for Interface Endpoint
###################################################

module "security_group" {
  source = "../security-group"

  vpc_id = var.vpc_id

  name        = try(var.default_security_group.name, local.metadata.name)
  description = try(var.default_security_group.description, "Managed by Terraform.")

  ingress_rules = concat(
    (length(try(var.default_security_group.ingress_cidrs, [])) > 0
      ? [{
        id          = "ipv4-cidrs"
        description = "Allow inbound traffic from the IPv4 CIDRs."
        protocol    = "tcp"
        from_port   = 0
        to_port     = 65535

        cidr_blocks = try(var.default_security_group.ingress_cidrs, [])
      }]
      : []
    ),
    (length(try(var.default_security_group.ingress_ipv6_cidrs, [])) > 0
      ? [{
        id          = "ipv6-cidrs"
        description = "Allow inbound traffic from the IPv6 CIDRs."
        protocol    = "tcp"
        from_port   = 0
        to_port     = 65535

        ipv6_cidr_blocks = try(var.default_security_group.ingress_ipv6_cidrs, [])
      }]
      : []
    ),
    (length(try(var.default_security_group.ingress_prefix_lists, [])) > 0
      ? [{
        id          = "prefix-lists"
        description = "Allow inbound traffic from the Prefix Lists."
        protocol    = "tcp"
        from_port   = 0
        to_port     = 65535

        prefix_list_ids = try(var.default_security_group.ingress_prefix_lists, [])
      }]
      : []
    ),
    [
      for security_group in try(var.default_security_group.ingress_security_groups, []) : {
        id          = "security-groups"
        description = "Allow inbound traffic from the source Security Groups."
        protocol    = "tcp"
        from_port   = 0
        to_port     = 65535

        source_security_group_id = security_group
      }
    ]
  )
  egress_rules = []

  revoke_rules_on_delete = true
  resource_group_enabled = false
  module_tags_enabled    = false

  tags = merge(
    local.module_tags,
    var.tags,
  )
}
