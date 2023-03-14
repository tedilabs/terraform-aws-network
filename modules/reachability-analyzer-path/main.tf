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
# Reachability Analyzer Path
###################################################

resource "aws_ec2_network_insights_path" "this" {
  protocol = lower(var.protocol)

  source    = var.source_network.id
  source_ip = var.source_network.ip_address

  destination      = var.destination_network.id
  destination_ip   = var.destination_network.ip_address
  destination_port = var.destination_network.port

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Reachability Analyzer Analysis
###################################################

resource "aws_ec2_network_insights_analysis" "this" {
  for_each = {
    for analysis in var.analyses :
    analysis.name => analysis
  }

  network_insights_path_id = aws_ec2_network_insights_path.this.id

  filter_in_arns      = each.value.required_intermediate_components
  wait_for_completion = each.value.wait_for_completion

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}
