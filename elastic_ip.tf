resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_public_bastion, module.vpc]
  instance   = module.ec2_public_bastion.id
  domain     = "vpc"
}
