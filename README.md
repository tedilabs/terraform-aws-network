# terraform-aws-network

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/tedilabs/terraform-aws-network?color=blue&sort=semver&style=flat-square)
![GitHub](https://img.shields.io/github/license/tedilabs/terraform-aws-network?color=blue&style=flat-square)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)

Terraform module which creates network related resources on AWS.

- [nacl](./modules/nacl)
- [nat-gateway](./modules/nat-gateway)
- [route-table](./modules/route-table)
- [security-group](./modules/security-group)
- [subnet-group](./modules/subnet-group)
- [vpc](./modules/vpc)


## Target AWS Services

Terraform Modules from [this package](https://github.com/tedilabs/terraform-aws-network) were written to manage the following AWS Services with Terraform.

- **AWS VPC (Virtual Private Cloud)**
  - VPC
    - Default Network ACL
    - Default Security Group
  - Subnet
  - Route Table
  - NACL (Network ACL)
  - Security Group
  - Gateways
    - Internet Gateway
    - Egress-only Internet Gateway
    - NAT Gateway
    - VPN Gateway (Virtual Private Gateway)


## Examples

### VPC

- [vpc-full](./examples/vpc-full)
- [vpc-ipv4-secondary-cidrs](./examples/vpc-ipv4-secondary-cidrs)
- [vpc-ipv6-cidrs](./examples/vpc-ipv6-cidrs)
- [vpc-simple](./examples/vpc-simple)
- [vpc-with-ipam](./examples/vpc-with-ipam)

### Security Group

- [security-group-simple](./examples/security-group-simple)
- [security-group-with-ipv4-cidrs](./examples/security-group-with-ipv4-cidrs)

### NAT Gateway

- [nat-gateway-public](./examples/nat-gateway-public/)
- [nat-gateway-private](./examples/nat-gateway-private/)
- [nat-gateway-private-secondary-ip-addresses](./examples/nat-gateway-private-secondary-ip-addresses)


## Other Terraform Modules from Tedilabs

Enjoying [terraform-aws-network](https://github.com/tedilabs/terraform-aws-network)? Check out some of our other modules:

- [AWS Container](https://github.com/tedilabs/terraform-aws-container) - A package of Terraform Modules to manage AWS Container resources.
- [AWS Domain](https://github.com/tedilabs/terraform-aws-domain) - A package of Terraform Modules to manage AWS Domain resources.
- [AWS IPAM](https://github.com/tedilabs/terraform-aws-ipam) - A package of Terraform Modules to manage AWS IPAM related resources (IPAM, Elastic IP, Prefix List).
- [AWS Load Balancer](https://github.com/tedilabs/terraform-aws-load-balancer) - A package of Terraform Modules to manage AWS Load Balancer resources.
- [AWS Security](https://github.com/tedilabs/terraform-aws-security) - A package of Terraform Modules to manage AWS Security resources.
- [AWS VPC Connectivity](https://github.com/tedilabs/terraform-aws-vpc-connectivity) - A package of Terraform Modules to manage AWS VPC Connectivity related resources (VPC Peering, VPC Private Link, VPC Lattice, Client VPN, Site-to-Site VPN, DX).

Or check out [the full list](https://github.com/search?q=org%3Atedilabs+topic%3Aterraform-module&type=repositories)


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-network). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2021-2023, [Byungjin Park](https://www.posquit0.com).
