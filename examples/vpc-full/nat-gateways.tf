###################################################
# Elastic IP
###################################################

module "elastic_ip" {
  source  = "tedilabs/ipam/aws//modules/elastic-ip"
  version = "~> 0.3.0"

  name = "nat-gw-test-public/az2"
  type = "AMAZON"

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}


###################################################
# Public NAT Gateway
###################################################

module "public_nat_gateway" {
  source = "../../modules/nat-gateway"
  # source  = "tedilabs/network/aws//modules/nat-gateway"
  # version = "~> 0.2.0"

  name       = "test-public/az2"
  is_private = false
  subnet     = module.public_subnet_group.subnets_by_az["use1-az2"][0].id


  ## Primary IP Address
  primary_ip_assignment = {
    elastic_ip = module.elastic_ip.id
  }


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}


###################################################
# Private NAT Gateway
###################################################

module "private_nat_gateway" {
  source = "../../modules/nat-gateway"
  # source  = "tedilabs/network/aws//modules/nat-gateway"
  # version = "~> 0.2.0"

  name       = "test-private/az2"
  is_private = true
  subnet     = module.private_subnet_group.subnets_by_az["use1-az2"][0].id


  ## Primary IP Address
  primary_ip_assignment = {
    private_ip = "10.0.200.7"
  }


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
