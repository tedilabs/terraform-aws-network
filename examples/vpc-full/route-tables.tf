###################################################
# Route Tables
###################################################

module "private_route_table" {
  source = "../../modules/route-table"
  # source  = "tedilabs/network/aws//modules/route-table"
  # version = "~> 0.2.0"

  name     = "test-private"
  vpc_id   = module.vpc.id
  subnets  = module.private_subnet_group.ids
  gateways = []


  ## Route Rules
  ipv4_routes = [
    {
      destination = "0.0.0.0/0"
      target = {
        type = "NAT_GATEWAY"
        id   = module.public_nat_gateway.id
      }
    },
  ]
  ipv6_routes        = []
  prefix_list_routes = []

  vpc_gateway_endpoints    = []
  propagating_vpn_gateways = []


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}

module "public_route_table" {
  source = "../../modules/route-table"
  # source  = "tedilabs/network/aws//modules/route-table"
  # version = "~> 0.2.0"

  name     = "test-public"
  vpc_id   = module.vpc.id
  subnets  = module.public_subnet_group.ids
  gateways = []


  ## Route Rules
  ipv4_routes = [
    {
      destination = "0.0.0.0/0"
      target = {
        type = "INTERNET_GATEWAY"
        id   = module.vpc.internet_gateway.id
      }
    },
  ]
  ipv6_routes        = []
  prefix_list_routes = []

  vpc_gateway_endpoints    = []
  propagating_vpn_gateways = []


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
