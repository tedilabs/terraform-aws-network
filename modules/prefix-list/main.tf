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

locals {
  max_entries = coalesce(var.max_entries, length(var.entries))
}

# INFO: Not support `aws_ec2_managed_prefix_list_entry`
# To improved execution times on larger updates, if you plan to create a prefix list with more than 100 entries, it is recommended that you use the inline entry block as part of the Managed Prefix List resource resource instead.
resource "aws_ec2_managed_prefix_list" "this" {
  name           = var.name
  address_family = var.address_family
  max_entries    = local.max_entries

  dynamic "entry" {
    for_each = var.entries

    content {
      cidr        = entry.value.cidr
      description = entry.value.description
    }
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
