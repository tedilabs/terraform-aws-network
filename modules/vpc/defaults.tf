###################################################
# Default NACL
###################################################

# INFO: Not supported attributes
# - `subnet_ids`
resource "aws_default_network_acl" "this" {
  region = var.region

  default_network_acl_id = aws_vpc.this.default_network_acl_id

  dynamic "ingress" {
    for_each = (length(var.default_network_acl.ingress_rules) == 0
      ? ["go"]
      : []
    )

    content {
      rule_no    = 100
      action     = "allow"
      protocol   = -1
      from_port  = 0
      to_port    = 0
      cidr_block = "0.0.0.0/0"
    }
  }

  dynamic "ingress" {
    for_each = (length(var.default_network_acl.ingress_rules) == 0 && local.ipv6_enabled
      ? ["go"]
      : []
    )

    content {
      rule_no         = 101
      action          = "allow"
      protocol        = -1
      from_port       = 0
      to_port         = 0
      ipv6_cidr_block = "::/0"
    }
  }

  dynamic "ingress" {
    for_each = var.default_network_acl.ingress_rules

    content {
      rule_no         = tonumber(ingress.key)
      action          = lower(ingress.value.action)
      protocol        = ingress.value.protocol
      from_port       = coalesce(ingress.value.from_port, 0)
      to_port         = coalesce(ingress.value.to_port, 0)
      cidr_block      = ingress.value.ipv4_cidr
      ipv6_cidr_block = ingress.value.ipv6_cidr
      icmp_type       = ingress.value.icmp_type
      icmp_code       = ingress.value.icmp_code
    }
  }

  dynamic "egress" {
    for_each = (length(var.default_network_acl.egress_rules) == 0
      ? ["go"]
      : []
    )

    content {
      rule_no    = 100
      action     = "allow"
      protocol   = -1
      from_port  = 0
      to_port    = 0
      cidr_block = "0.0.0.0/0"
    }
  }

  dynamic "egress" {
    for_each = (length(var.default_network_acl.egress_rules) == 0 && local.ipv6_enabled
      ? ["go"]
      : []
    )

    content {
      rule_no         = 101
      action          = "allow"
      protocol        = -1
      from_port       = 0
      to_port         = 0
      ipv6_cidr_block = "::/0"
    }
  }

  dynamic "egress" {
    for_each = var.default_network_acl.egress_rules

    content {
      rule_no         = tonumber(egress.key)
      action          = lower(egress.value.action)
      protocol        = egress.value.protocol
      from_port       = coalesce(egress.value.from_port, 0)
      to_port         = coalesce(egress.value.to_port, 0)
      cidr_block      = egress.value.ipv4_cidr
      ipv6_cidr_block = egress.value.ipv6_cidr
      icmp_type       = egress.value.icmp_type
      icmp_code       = egress.value.icmp_code
    }
  }

  tags = merge(
    {
      "Name" = coalesce(var.default_network_acl.name, local.metadata.name)
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}


###################################################
# Default Route Table
###################################################

# resource "aws_default_route_table" "this" {
#   region = var.region
#
#   default_route_table_id = aws_vpc.this.default_route_table_id
#
#   tags = merge(
#     {
#       "Name" = coalesce(var.default_route_table.name, local.metadata.name)
#     },
#     local.module_tags,
#     var.tags,
#   )
# }


###################################################
# Default Security Group
###################################################

resource "aws_default_security_group" "this" {
  region = var.region

  vpc_id = aws_vpc.this.id

  dynamic "ingress" {
    for_each = (var.default_security_group.ingress_rules == null
      ? ["go"]
      : []
    )

    content {
      protocol  = -1
      from_port = 0
      to_port   = 0
      self      = true
    }
  }

  dynamic "ingress" {
    for_each = (var.default_security_group.ingress_rules != null
      ? var.default_security_group.ingress_rules
      : []
    )

    content {
      description      = ingress.value.description
      protocol         = ingress.value.protocol
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      cidr_blocks      = ingress.value.ipv4_cidrs
      ipv6_cidr_blocks = ingress.value.ipv6_cidrs
      prefix_list_ids  = ingress.value.prefix_lists
      security_groups  = ingress.value.security_groups
      self             = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = (var.default_security_group.egress_rules == null
      ? ["go"]
      : []
    )

    content {
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = (var.default_security_group.egress_rules == null && local.ipv6_enabled
      ? ["go"]
      : []
    )

    content {
      protocol         = -1
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  dynamic "egress" {
    for_each = (var.default_security_group.egress_rules != null
      ? var.default_security_group.egress_rules
      : []
    )

    content {
      description      = egress.value.description
      protocol         = egress.value.protocol
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      cidr_blocks      = egress.value.ipv4_cidrs
      ipv6_cidr_blocks = egress.value.ipv6_cidrs
      prefix_list_ids  = egress.value.prefix_lists
      security_groups  = egress.value.security_groups
      self             = egress.value.self
    }
  }

  tags = merge(
    {
      "Name" = coalesce(var.default_security_group.name, local.metadata.name)
    },
    local.module_tags,
    var.tags,
  )
}
