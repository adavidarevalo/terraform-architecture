# module "ec2_app3_private" {
#   depends_on = [data.aws_ami.ec2_ubuntu_ami, module.vpc, module.rdsDb]
#   source     = "terraform-aws-modules/ec2-instance/aws"
#   version    = "5.6.1"

#   name = "${local.environment}-app3-private"

#   ami = data.aws_ami.ec2_ubuntu_ami.id

#   instance_type = var.instace_type

#   for_each = toset(["0", "1"])

#   availability_zone = data.aws_availability_zones.AvailabilityZones.names[tonumber(each.key)]

#   key_name = var.instance_keypair

#   vpc_security_group_ids = [module.private_sg.security_group_id]

#   subnet_id = module.vpc.private_subnets[tonumber(each.key)]

#   user_data = templatefile("${path.module}/template-function/app3-ums-install.tmpl", {
#     rds_db_endpoint = module.rdsDb.db_instance_domain != null ? module.rdsDb.db_instance_domain : replace(module.rdsDb.db_instance_address, ":3306", "")
#     rds_password    = var.db_password
#     rds_username    = module.rdsDb.db_instance_username
#     rds_db_name     = module.rdsDb.db_instance_name
#   })

#   # user_data = file("${path.module}/app3-ums-install.sh")


#   tags = merge(local.common_tags, {
#     Name = "${local.environment}-${each.key}-app3-private"
#   })
# }

