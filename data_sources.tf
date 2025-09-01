data "aws_caller_identity" "current" {}

locals {
  route53_zone_calculated = {
    for ses_key, ses_config in var.ses_parameters :
    ses_key => {
      "private_zone" = try(ses_config.private_zone, false)
    } if(try(ses_config.verify_domain, true) != false || try(ses_config.verify_dkim, true) != false)
  }
}

data "aws_route53_zone" "this" {
  for_each     = local.route53_zone_calculated
  name         = each.key
  private_zone = false
}