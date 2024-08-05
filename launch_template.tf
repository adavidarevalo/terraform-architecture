resource "aws_launch_template" "my_launch_template" {
  depends_on = [data.aws_ami.ec2_ubuntu_ami, module.vpc, module.rdsDb]
  name       = "my_launch_template"

  image_id      = data.aws_ami.ec2_ubuntu_ami.id
  instance_type = var.instace_type

  user_data = base64encode(templatefile("${path.module}/template-function/app3-ums-install.tpl", {
    rds_db_endpoint = "${module.rdsDb.db_instance_domain != null ? module.rdsDb.db_instance_domain : replace(module.rdsDb.db_instance_address, ":3306", "")}"
    rds_password    = "${var.db_password}"
    rds_username    = "${module.rdsDb.db_instance_username}"
    rds_db_name     = "${module.rdsDb.db_instance_name}"
  }))

  vpc_security_group_ids = [module.private_sg.security_group_id]

  key_name = var.instance_keypair

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size           = 20
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }

  monitoring {
    enabled = true
  }

  tags = merge(local.common_tags, {
    Name = "${local.environment}-launch-template"
  })
}
