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
  region = var.region

  id = var.subnet
}


###################################################
# NAT Gateway
###################################################

# INFO: Use a separate resource
# - `secondary_allocation_ids`
resource "aws_nat_gateway" "this" {
  region = var.region

  connectivity_type = var.is_private ? "private" : "public"
  subnet_id         = var.subnet


  ## Public IP Addresses
  allocation_id = var.public_ip_assignments.primary_elastic_ip


  ## Private IP Addresses
  private_ip = var.private_ip_assignments.primary_private_ip
  secondary_private_ip_addresses = (var.private_ip_assignments.secondary_private_ip_count == 0
    ? var.private_ip_assignments.secondary_private_ips
    : null
  )
  secondary_private_ip_address_count = var.private_ip_assignments.secondary_private_ip_count > 0 ? var.private_ip_assignments.secondary_private_ip_count : null


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
        var.private_ip_assignments.secondary_private_ip_count == 0,
        var.private_ip_assignments.secondary_private_ip_count != 0 && var.is_private == true,
      ])
      error_message = "`secondary_private_ip_address_count` can only be set for private NAT Gateway."
    }
  }
}


###################################################
# Secondary Elastic IPs for NAT Gateway
###################################################

resource "aws_nat_gateway_eip_association" "this" {
  for_each = toset(var.public_ip_assignments.secondary_elastic_ips)

  region = aws_nat_gateway.this.region

  nat_gateway_id = aws_nat_gateway.this.id
  allocation_id  = each.value
}
