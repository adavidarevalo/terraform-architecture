module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = "public-bastion-sg"
  description = "Security group with SSH port open for ubuntu dev ip, egress ports are all open for the world"
  vpc_id      = module.vpc.vpc_id

  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["136.36.44.79/32"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

  tags = merge(local.common_tags, {
    Name = "public-bastion-sg"
  })
}

