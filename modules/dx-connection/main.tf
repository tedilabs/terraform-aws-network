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
  encryption_mode = {
    "NO_ENCRYPT"     = "no_encrypt"
    "SHOULD_ENCRYPT" = "should_encrypt"
    "MUST_ENCRYPT"   = "must_encrypt"
  }
}


###################################################
# Direct Connect Location
###################################################

data "aws_dx_location" "this" {
  location_code = var.location_code
}


###################################################
# Direct Connect Connection
###################################################

resource "aws_dx_connection" "this" {
  name         = local.metadata.name
  skip_destroy = var.skip_destroy
  bandwidth    = var.bandwidth

  location      = data.aws_dx_location.this.location_code
  provider_name = var.service_provider

  request_macsec = var.encryption.request_macsec_capable_port
  encryption_mode = (var.encryption.mode != null
    ? local.encryption_mode[var.encryption.mode]
    : null
  )

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

# INFO: Not supported attributes
# - `secret_arn`
resource "aws_dx_macsec_key_association" "this" {
  count = alltrue([
    var.encryption.request_macsec_capable_port,
    var.encryption.macsec_key_pair != null,
  ]) ? 1 : 0

  connection_id = aws_dx_connection.this.id

  ckn = try(var.encryption.macsec_key_pair.ckn, null)
  cak = try(var.encryption.macsec_key_pair.cak, null)
}
