resource "aws_security_group" "this" {
  vpc_id  = var.vpc_id

  name        = var.name
  name_prefix = var.name_prefix
  description = var.description

  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}


###################################################
# Security Group Rules
###################################################

locals {
  normalized_ingress_rules = [
    for rule in var.ingress_rules:
      {
        description = lookup(rule, "description", "Managed by Terraform"),

        protocol  = rule.protocol,
        from_port = rule.from_port,
        to_port   = rule.to_port,

        cidr_blocks              = lookup(rule, "cidr_blocks", null) != null ? sort(compact(rule.cidr_blocks)) : null,
        ipv6_cidr_blocks         = lookup(rule, "ipv6_cidr_blocks", null) != null ? sort(compact(rule.ipv6_cidr_blocks)) : null,
        prefix_list_ids          = lookup(rule, "prefix_list_ids", null) != null ? sort(compact(rule.prefix_list_ids)) : null,
        source_security_group_id = lookup(rule, "source_security_group_id", null),
        self                     = lookup(rule, "self", null) != null ? true : null,
      }
  ]
  normalized_egress_rules = [
    for rule in var.egress_rules:
      {
        description = lookup(rule, "description", "Managed by Terraform"),

        protocol  = rule.protocol,
        from_port = rule.from_port,
        to_port   = rule.to_port,

        cidr_blocks              = lookup(rule, "cidr_blocks", null) != null ? sort(compact(rule.cidr_blocks)) : null,
        ipv6_cidr_blocks         = lookup(rule, "ipv6_cidr_blocks", null) != null ? sort(compact(rule.ipv6_cidr_blocks)) : null,
        prefix_list_ids          = lookup(rule, "prefix_list_ids", null) != null ? sort(compact(rule.prefix_list_ids)) : null,
        source_security_group_id = lookup(rule, "source_security_group_id", null),
        self                     = lookup(rule, "self", null) != null ? true : null,
      }
  ]

  # Filter if empty
  compacted_ingress_rules = [
    for rule in local.normalized_ingress_rules:
      rule if length(compact(flatten([
        rule.cidr_blocks,
        rule.ipv6_cidr_blocks,
        rule.prefix_list_ids,
        rule.source_security_group_id,
        rule.self != null ? "self" : null,
      ]))) > 0
  ]
  compacted_egress_rules = [
    for rule in local.normalized_egress_rules:
      rule if length(compact(flatten([
        rule.cidr_blocks,
        rule.ipv6_cidr_blocks,
        rule.prefix_list_ids,
        rule.source_security_group_id,
        rule.self != null ? "self" : null,
      ]))) > 0
  ]

  ingress_rules = {
    for rule in local.compacted_ingress_rules:
      join("_", compact(flatten([
        rule.protocol,
        rule.from_port,
        rule.to_port,
        rule.cidr_blocks,
        rule.ipv6_cidr_blocks,
        rule.prefix_list_ids,
        rule.source_security_group_id,
        rule.self != null ? "self" : null,
      ]))) => rule
  }
  egress_rules = {
    for rule in local.compacted_egress_rules:
      join("_", compact(flatten([
        rule.protocol,
        rule.from_port,
        rule.to_port,
        rule.cidr_blocks,
        rule.ipv6_cidr_blocks,
        rule.prefix_list_ids,
        rule.source_security_group_id,
        rule.self != null ? "self" : null,
      ]))) => rule
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = local.ingress_rules

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  description       = each.value.description

  protocol  = each.value.protocol
  from_port = each.value.from_port
  to_port   = each.value.to_port

  cidr_blocks              = each.value.cidr_blocks
  ipv6_cidr_blocks         = each.value.ipv6_cidr_blocks
  prefix_list_ids          = each.value.prefix_list_ids
  source_security_group_id = each.value.source_security_group_id
  self                     = each.value.self
}

resource "aws_security_group_rule" "egress" {
  for_each = local.egress_rules

  security_group_id = aws_security_group.this.id
  type              = "egress"
  description       = each.value.description

  protocol  = each.value.protocol
  from_port = each.value.from_port
  to_port   = each.value.to_port

  cidr_blocks              = each.value.cidr_blocks
  ipv6_cidr_blocks         = each.value.ipv6_cidr_blocks
  prefix_list_ids          = each.value.prefix_list_ids
  source_security_group_id = each.value.source_security_group_id
  self                     = each.value.self
}
