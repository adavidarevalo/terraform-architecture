resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.myDomain.zone_id
  name    = "apps.davidarevalo.xyz"
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}
