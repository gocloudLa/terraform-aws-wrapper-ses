module "ses" {

  source = "./modules/aws/terraform-aws-ses"

  for_each = var.ses_parameters

  create_domain = true
  domain        = each.key
  zone_id       = try(each.value.zone_id, var.ses_defaults.zone_id, data.aws_route53_zone.this[each.key].zone_id, null)
  verify_domain = try(each.value.verify_domain, var.ses_defaults.verify_domain, true)
  verify_dkim   = try(each.value.verify_dkim, var.ses_defaults.verify_dkim, true)
  iam_name      = try(each.value.iam_name, var.ses_defaults.iam_name, "ses-${each.key}")

  create_secret          = try(each.value.create_secret, var.ses_defaults.create_secret, true)
  description            = try(each.value.description, var.ses_defaults.description, null)
  kms_key_id             = try(each.value.kms_key_id, var.ses_defaults.kms_key_id, null)
  name                   = try(each.value.create_domain, var.ses_defaults.create_domain, "ses-${each.key}")
  name_prefix            = try(each.value.create_domain, var.ses_defaults.create_domain, "")
  pass_version           = try(each.value.create_domain, var.ses_defaults.create_domain, 1)
  notification_topic     = try(each.value.notification_topic, var.ses_defaults.notification_topic, {})
  default_sns_topic_name = try(each.value.default_sns_topic_name, var.ses_defaults.default_sns_topic_name, local.default_sns_topic_name)

  tags = merge(local.common_tags, try(each.value.tags, var.ses_defaults.tags, null))

}
