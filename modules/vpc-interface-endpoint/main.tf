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

resource "aws_vpc_endpoint" "this" {
  vpc_endpoint_type  = "Interface"
  service_name       = var.service_name
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnets
  security_group_ids = var.security_group_ids

  private_dns_enabled = var.private_dns_enabled
  auto_accept         = var.auto_accept
  policy              = var.policy

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Notification
###################################################

resource "aws_vpc_endpoint_connection_notification" "this" {
  for_each = {
    for config in try(var.notification_configurations, []) :
    config.sns_arn => config
  }

  vpc_endpoint_id = aws_vpc_endpoint.this.id

  connection_notification_arn = each.key
  connection_events           = try(each.value.events, [])
}
