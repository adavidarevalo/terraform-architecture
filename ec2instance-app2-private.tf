module "ec2_app2_private" {
  depends_on = [data.aws_ami.ec2_ubuntu_ami, module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.6.1"

  name = "${local.environment}-app2-private"

  ami = data.aws_ami.ec2_ubuntu_ami.id

  instance_type = var.instace_type

  for_each = toset(["0", "1"])

  availability_zone = data.aws_availability_zones.AvailabilityZones.names[tonumber(each.key)]

  key_name = var.instance_keypair

  vpc_security_group_ids = [module.private_sg.security_group_id]

  subnet_id = module.vpc.private_subnets[tonumber(each.key)]

  user_data = file("${path.module}/ec2-userData/apache-app2-install.sh")

  tags = merge(local.common_tags, {
    Name = "${local.environment}-${each.key}-app2-private"
  })
}

