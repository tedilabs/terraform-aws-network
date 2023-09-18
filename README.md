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
  - Subnet
  - Route Table
  - NACL (Network ACL)
  - Security Group
  - Gateways
    - Internet Gateway
    - NAT Gateway


## Examples

### VPC

- To be added


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-network). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2021-2023, [Byungjin Park](https://www.posquit0.com).
