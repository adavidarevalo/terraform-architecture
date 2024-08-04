# resource "aws_route53_record" "default_dns" {
#   zone_id = data.aws_route53_zone.myDomain.zone_id
#   name    = "apps.${local.domain}"
#   type    = "A"
#   alias {
#     name                   = module.alb.dns_name
#     zone_id                = module.alb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "app1_dns" {
#   zone_id = data.aws_route53_zone.myDomain.zone_id
#   name    = "app1.${local.domain}"
#   type    = "A"
#   alias {
#     name                   = module.alb.dns_name
#     zone_id                = module.alb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "app2_dns" {
#   zone_id = data.aws_route53_zone.myDomain.zone_id
#   name    = "app2.${local.domain}"
#   type    = "A"
#   alias {
#     name                   = module.alb.dns_name
#     zone_id                = module.alb.zone_id
#     evaluate_target_health = true
#   }
# }

resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.myDomain.zone_id
  name    = "dns-to-db.${local.domain}"
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}