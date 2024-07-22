module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.9.0"

  name               = "${local.name}-alb"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  load_balancer_type = "application"
  security_groups    = [module.load_balancer_sg.security_group_id]

  listeners = {
    my-http-litener = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "mytg1"
      }
    }
  }

  target_groups = {
    mytg1 = {
      create_attachment    = false
      name_prefix          = "h1"
      protocol             = "HTTP"
      port                 = 80
      target_type          = "instance"
      deregistration_delay = 10
      protocol_version     = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "80"
        protocol            = "HTTP"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        matcher             = "200-399"
      }

      tags = merge(local.common_tags, {
        Name = "${local.environment}-taget-group"
      })
    }
  }

  tags = merge(local.common_tags, {
    Name = "${local.environment}-alb"
  })
}

resource "aws_lb_target_group_attachment" "mytg1" {
    for_each = {for k, v in module.ec2_private: k => v}
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}
