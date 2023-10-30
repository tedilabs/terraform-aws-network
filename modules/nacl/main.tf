locals {
  metadata = {
    package = "terraform-aws-network"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}


###################################################
# Network ACL
###################################################

# INFO: Not supported attributes
# - `ingress`
# - `egress`
resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Subnet Associations of Network ACL
###################################################

# resource "aws_network_acl_association" "this" {
#   for_each = toset(var.subnets)
#
#   network_acl_id = aws_network_acl.this.id
#   subnet_id      = each.value
# }


###################################################
# Network ACL Rules
###################################################

resource "aws_network_acl_rule" "ingress" {
  for_each = var.ingress_rules

  network_acl_id = aws_network_acl.this.id

  egress      = false
  rule_number = each.key

  rule_action     = lower(each.value.action)
  protocol        = each.value.protocol
  from_port       = each.value.from_port
  to_port         = each.value.to_port
  icmp_type       = each.value.icmp_type
  icmp_code       = each.value.icmp_code
  cidr_block      = each.value.ipv4_cidr
  ipv6_cidr_block = each.value.ipv6_cidr
}

resource "aws_network_acl_rule" "egress" {
  for_each = var.egress_rules

  network_acl_id = aws_network_acl.this.id

  egress      = true
  rule_number = each.key

  rule_action     = lower(each.value.action)
  protocol        = each.value.protocol
  from_port       = each.value.from_port
  to_port         = each.value.to_port
  icmp_type       = each.value.icmp_type
  icmp_code       = each.value.icmp_code
  cidr_block      = each.value.ipv4_cidr
  ipv6_cidr_block = each.value.ipv6_cidr
}
