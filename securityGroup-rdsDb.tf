module "rdsDb_sg" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/security-group/aws"
  version    = "5.1.2"

  name        = "rdsdb-sg"
  description = "Access to MySQL DB for entire VPC CIDR Block"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  egress_rules = ["all-all"]

  tags = merge(local.common_tags, {
    Name = "rdsDb-sg"
  })
}

