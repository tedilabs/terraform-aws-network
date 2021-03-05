resource "aws_eip" "this" {
  count = var.assign_eip_on_create ? 1 : 0

  vpc = true

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "this" {
  subnet_id     = var.subnet_id
  allocation_id = var.assign_eip_on_create ? aws_eip.this[0].id : var.eip_id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
