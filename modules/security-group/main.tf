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
# Security Group
###################################################

# INFO: Not supported attributes
# - `name_prefix`
# INFO: Use a separate resource
# - `egress`
# - `ingress`
resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  name = var.name
  # name_prefix = var.name_prefix
  description = var.description

  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}
