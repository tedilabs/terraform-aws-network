resource "aws_eip" "this" {
  count = var.eip_id != "" ? 0 : 1

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
  allocation_id = var.eip_id != "" ? var.eip_id : aws_eip.this[0].id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
