# module "clasic-lb" {
#   source  = "terraform-aws-modules/elb/aws"
#   version = "4.0.2"

#   name = "${local.name}-clasic-elb"

#   security_groups = [module.load_balancer_sg.security_group_id]

#   subnets = module.vpc.public_subnets

#   internal = false

#   listener = [
#     {
#       instance_port     = 80
#       instance_protocol = "HTTP"
#       lb_port           = 80
#       lb_protocol       = "HTTP"
#     },
#     {
#       instance_port     = 80
#       instance_protocol = "HTTP"
#       lb_port           = 81
#       lb_protocol       = "HTTP"
#       #   ssl_certificate_id = module.acm.this_acm_certificate_arn
#     }
#   ]

#   health_check = {
#     target              = "HTTP:80/"
#     interval            = 30
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#   }

#   number_of_instances = var.private_instance_count
#   instances           = toset([for instance in module.ec2_app1_private : instance.id])



#   tags = merge(local.common_tags, {
#     Name = "${local.environment}-clasicLB"
#   })

# } 