module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.1"


  domain_name = trimsuffix(data.aws_route53_zone.myDomain.name, ".")
  zone_id     = data.aws_route53_zone.myDomain.zone_id

  validation_method = "DNS"

  wait_for_validation = true

  subject_alternative_names = [
    "*.${local.domain}"
  ]

  tags = merge(local.common_tags, {
    Name = "${local.environment}-acm"
  })
}
