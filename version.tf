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
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}



provider "aws" {
  region  = var.aws_region
  profile = "default"

}

resource "random_pet" "this" {
  length = 2
}