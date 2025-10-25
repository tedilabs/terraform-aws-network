###################################################
# Resource Sharing by RAM (Resource Access Manager)
###################################################

module "share" {
  source  = "tedilabs/organization/aws//modules/ram-share"
  version = "~> 0.4.0"

  for_each = {
    for share in var.shares :
    share.name => share
  }

  region = values(aws_subnet.this)[0].region

  name = "vpc.subnet-group.${var.name}.${each.key}"

  resources = values(aws_subnet.this)[*].arn

  permissions = each.value.permissions

  external_principals_allowed = each.value.external_principals_allowed
  principals                  = each.value.principals

  resource_group = {
    enabled = false
  }
  module_tags_enabled = false

  tags = merge(
    local.module_tags,
    var.tags,
    each.value.tags,
  )
}
