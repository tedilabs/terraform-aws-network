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

resource "aws_vpc_endpoint_service" "this" {
  gateway_load_balancer_arns = var.gateway_load_balancer_arns
  network_load_balancer_arns = var.network_load_balancer_arns

  private_dns_name    = var.private_domain
  acceptance_required = var.acceptance_required

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Allowed Principals
###################################################

resource "aws_vpc_endpoint_service_allowed_principal" "this" {
  for_each = toset(var.allowed_principals)

  vpc_endpoint_service_id = aws_vpc_endpoint_service.this.id
  principal_arn           = each.value
}


###################################################
# Notification
###################################################

resource "aws_vpc_endpoint_connection_notification" "this" {
  for_each = {
    for config in try(var.notification_configurations, []) :
    config.sns_arn => config
  }

  vpc_endpoint_service_id = aws_vpc_endpoint_service.this.id

  connection_notification_arn = each.key
  connection_events           = try(each.value.events, [])
}
