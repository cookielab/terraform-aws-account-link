terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      version = ">= 3.30.0"
      source  = "hashicorp/aws"
    }
  }
}
