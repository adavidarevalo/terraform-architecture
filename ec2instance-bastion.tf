module "ec2_public_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  depends_on = [module.vpc]

  name = "${local.environment}-BastionHost"

  ami = data.aws_ami.ec2_ubuntu_ami.id

  instance_type = var.instace_type

  availability_zone = data.aws_availability_zones.AvailabilityZones.names[0]

  key_name = var.instance_keypair

  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]

  subnet_id = module.vpc.public_subnets[0]

  tags = merge(local.common_tags, {
    Name = "${local.environment}-BastionHost"
  })
}

