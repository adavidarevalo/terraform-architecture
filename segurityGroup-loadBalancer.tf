module "load_balancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = "load-balancer-sg"
  description = "Http open for the internet"
  vpc_id      = module.vpc.vpc_id

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

    ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow 81 from internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = merge(local.common_tags, {
    Name = "load-balancer-sg"
  })
}

