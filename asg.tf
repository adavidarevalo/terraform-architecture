resource "aws_autoscaling_group" "express-app-autoscaling" {
  name                      = "express-app-autoscaling"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = module.vpc.private_subnets
  target_group_arns         = [module.alb.target_groups["mytg3"].arn]

  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }


  tag {
    key                 = "Name"
    value               = "${local.environment}-express-app-autoscaling"
    propagate_at_launch = true
  }
}