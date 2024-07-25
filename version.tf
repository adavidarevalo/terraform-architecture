terraform {
  required_version = ">= 1.9.2, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "5.58.0"
    }
    null = {
      source  = "hashicorp/null",
      version = "3.2.2"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"

}
