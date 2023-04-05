terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.60"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4"
    }
  }
}
