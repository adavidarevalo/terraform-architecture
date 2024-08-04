module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.9.0"

  name                       = "${local.name}-alb"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  load_balancer_type         = "application"
  enable_deletion_protection = false
  security_groups            = [module.load_balancer_sg.security_group_id]
  listeners = {
    my-http-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = 443
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    my-http-litener = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = module.acm.acm_certificate_arn
      fixed_response = {
        content_type = "text/plain"
        message_body = "Hello World!"
        status_code  = 200
      }
      rules = {
        myapp1-rule = {
          actions = [{
            type     = "weighted-forward"
            priority = 1
            target_groups = [
              {
                target_group_key = "mytg1"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/app1*"]
            }
          }]
        }
        myapp2-rule = {
          priority = 2
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg2"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/app2*"]
            }
          }]
        }
        myapp3-rule = {
          priority = 3
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg3"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/*"]
            }
          }]
        }
      }
    }

  }

  target_groups = {
    mytg1 = {
      create_attachment                             = false
      name_prefix                                   = "mytg1-"
      protocol                                      = "HTTP"
      port                                          = 80
      target_type                                   = "instance"
      deregistration_delay                          = 10
      load_balancidbpassword11ng_cross_zone_enabled = false
      protocol_version                              = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }                        # End of Health Check Block
      tags = local.common_tags # Target Group Tags 
    }                          # END of Target Group-1: mytg1

    mytg2 = {
      create_attachment                 = false
      name_prefix                       = "mytg2-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      protocol_version                  = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = local.common_tags # Target Group Tags 
    }
    mytg3 = {
      create_attachment                 = false
      name_prefix                       = "mytg3-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      protocol_version                  = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = local.common_tags
    } # END of Target Group-3: mytg3
  }

  tags = merge(local.common_tags, {
    Name = "${local.environment}-alb"
  })
}

resource "aws_lb_target_group_attachment" "mytg1" {
  for_each         = { for k, v in module.ec2_app1_private : k => v }
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "mytg2" {
  for_each         = { for k, v in module.ec2_app2_private : k => v }
  target_group_arn = module.alb.target_groups["mytg2"].arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "mytg3" {
  for_each         = { for k, v in module.ec2_app3_private : k => v }
  target_group_arn = module.alb.target_groups["mytg3"].arn
  target_id        = each.value.id
  port             = 80
}

