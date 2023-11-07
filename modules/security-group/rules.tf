locals {
  normalized_ingress_rules = concat([], [
    for rule in var.ingress_rules :
    concat(
      [
        for idx, cidr in rule.ipv4_cidrs :
        {
          id          = "${rule.id}/ipv4/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = cidr
          ipv6_cidr      = null
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, cidr in rule.ipv6_cidrs :
        {
          id          = "${rule.id}/ipv6/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = cidr
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, prefix_list in rule.prefix_lists :
        {
          id          = "${rule.id}/prefix-list/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = prefix_list
          security_group = null
        }
      ],
      [
        for idx, security_group in rule.security_groups :
        {
          id          = "${rule.id}/security-group/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = security_group
        }
      ],
      [
        for self in [rule.self] :
        {
          id          = "${rule.id}/self"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = aws_security_group.this.id
        }
        if self
      ]
    )
  ]...)
  normalized_egress_rules = concat([], [
    for rule in var.egress_rules :
    concat(
      [
        for idx, cidr in rule.ipv4_cidrs :
        {
          id          = "${rule.id}/ipv4/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = cidr
          ipv6_cidr      = null
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, cidr in rule.ipv6_cidrs :
        {
          id          = "${rule.id}/ipv6/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = cidr
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, prefix_list in rule.prefix_lists :
        {
          id          = "${rule.id}/prefix-list/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = prefix_list
          security_group = null
        }
      ],
      [
        for idx, security_group in rule.security_groups :
        {
          id          = "${rule.id}/security-group/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = security_group
        }
      ],
      [
        for self in [rule.self] :
        {
          id          = "${rule.id}/self"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = aws_security_group.this.id
        }
        if self
      ]
    )
  ]...)
}


###################################################
# Ingress Rules for Security Group
###################################################

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = {
    for rule in local.normalized_ingress_rules :
    rule.id => rule
  }

  security_group_id = aws_security_group.this.id
  description       = each.value.description

  ip_protocol = each.value.protocol
  from_port = (contains(["all", "-1"], each.value.protocol)
    ? null
    : each.value.from_port
  )
  to_port = (contains(["all", "-1"], each.value.protocol)
    ? null
    : each.value.to_port
  )

  cidr_ipv4                    = each.value.ipv4_cidr
  cidr_ipv6                    = each.value.ipv6_cidr
  prefix_list_id               = each.value.prefix_list
  referenced_security_group_id = each.value.security_group

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Egress Rules for Security Group
###################################################

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = {
    for rule in local.normalized_egress_rules :
    rule.id => rule
  }

  security_group_id = aws_security_group.this.id
  description       = each.value.description

  ip_protocol = each.value.protocol
  from_port = (contains(["all", "-1"], each.value.protocol)
    ? null
    : each.value.from_port
  )
  to_port = (contains(["all", "-1"], each.value.protocol)
    ? null
    : each.value.to_port
  )

  cidr_ipv4                    = each.value.ipv4_cidr
  cidr_ipv6                    = each.value.ipv6_cidr
  prefix_list_id               = each.value.prefix_list
  referenced_security_group_id = each.value.security_group

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}
