module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"

  name = local.name
  cidr = "10.0.0.0/16"

  azs              = toset(data.aws_availability_zones.AvailabilityZones.names)
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = local.environment
  }
  private_subnet_tags = {
    Type = "private-subnets"
  }

  public_subnet_tags = {
    Type = "public-subnets"
  }

  database_subnet_tags = {
    Type = "databbase-subnets"
  }

  vpc_tags = {
    Name = "vpc-${local.environment}"
  }
}

