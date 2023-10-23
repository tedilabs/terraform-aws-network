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

data "aws_subnet" "this" {
  id = var.subnet
}


###################################################
# NAT Gateway
###################################################

resource "aws_nat_gateway" "this" {
  connectivity_type = var.is_private ? "private" : "public"
  subnet_id         = var.subnet


  ## Primary IP Addresse
  allocation_id = var.primary_ip_assignment.elastic_ip
  private_ip    = var.primary_ip_assignment.private_ip


  ## Secondary IP Addresses
  secondary_allocation_ids = (!var.is_private
    ? [
      for assignment in var.secondary_ip_assignments :
      assignment.elastic_ip
    ]
    : null
  )
  secondary_private_ip_addresses = (var.secondary_ip_count == null
    ? [
      for assignment in var.secondary_ip_assignments :
      assignment.private_ip
    ]
    : null
  )
  secondary_private_ip_address_count = var.secondary_ip_count

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    precondition {
      condition = anytrue([
        var.secondary_ip_count == null,
        var.secondary_ip_count != null && var.is_private == true,
      ])
      error_message = "`secondary_ip_count` variable is only supported with private NAT Gateway."
    }
  }
}
