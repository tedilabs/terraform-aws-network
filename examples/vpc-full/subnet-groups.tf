###################################################
# Subnet Groups
###################################################

module "private_subnet_group" {
  source = "../../modules/subnet-group"
  # source  = "tedilabs/network/aws//modules/subnet-group"
  # version = "~> 0.2.0"

  name = "test-private"

  vpc_id = module.vpc.id

  subnets = {
    "test-private/az2" = {
      availability_zone_id = "use1-az2"
      ipv4_cidr            = "10.0.200.0/24"
    }
    "test-private/az4" = {
      availability_zone_id = "use1-az4"
      ipv4_cidr            = "10.0.201.0/24"
    }
  }


  ## IP Assignments
  public_ipv4_address_assignment = {
    enabled = false
  }
  ipv6_address_assignment = {
    enabled = false
  }
  customer_owned_ipv4_address_assignment = {
    enabled = false
  }


  ## DNS Configurations
  dns_config = {
    hostname_type                  = "RESOURCE_NAME"
    dns_resource_name_ipv4_enabled = true
    dns_resource_name_ipv6_enabled = false
    dns64_enabled                  = false
  }

  ## Integrations
  dax_subnet_group = {
    enabled     = true
    name        = "test-dax"
    description = "Test DAX Subnet Group"
  }
  dms_replication_subnet_group = {
    enabled     = true
    name        = "test-dms-replication"
    description = "Test DMS Replication Subnet Group"
  }
  docdb_subnet_group = {
    enabled     = true
    name        = "test-docdb"
    description = "Test DocumentDB Subnet Group"
  }
  elasticache_subnet_group = {
    enabled     = true
    name        = "test-elasticache"
    description = "Test ElastiCache Subnet Group"
  }
  memorydb_subnet_group = {
    enabled     = true
    name        = "test-memorydb"
    description = "Test MemoryDB Subnet Group"
  }
  neptune_subnet_group = {
    enabled     = true
    name        = "test-neptune"
    description = "Test Neptune Subnet Group"
  }
  rds_subnet_group = {
    enabled     = true
    name        = "test-rds"
    description = "Test RDS Subnet Group"
  }
  redshift_subnet_group = {
    enabled     = true
    name        = "test-redshift"
    description = "Test Redshift Subnet Group"
  }


  ## Sharing
  shares = [
    # {
    #   name = "team1"
    #   principals = ["123456789012"]
    # },
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}

module "public_subnet_group" {
  source = "../../modules/subnet-group"
  # source  = "tedilabs/network/aws//modules/subnet-group"
  # version = "~> 0.2.0"

  name = "test-public"

  vpc_id = module.vpc.id

  subnets = {
    "test-public/az2" = {
      availability_zone_id = "use1-az2"
      ipv4_cidr            = "10.0.100.0/24"
    }
    "test-public/az4" = {
      availability_zone_id = "use1-az4"
      ipv4_cidr            = "10.0.101.0/24"
    }
  }


  ## IP Assignments
  public_ipv4_address_assignment = {
    enabled = true
  }
  ipv6_address_assignment = {
    enabled = false
  }
  customer_owned_ipv4_address_assignment = {
    enabled = false
  }


  ## DNS Configurations
  dns_config = {
    hostname_type                  = "RESOURCE_NAME"
    dns_resource_name_ipv4_enabled = true
    dns_resource_name_ipv6_enabled = false
    dns64_enabled                  = false
  }


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
