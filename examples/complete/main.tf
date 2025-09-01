module "wrapper_ses" {
  source = "../../"

  metadata = local.metadata

  ses_parameters = {
    "${local.zone_public}" = {
      # zone_id       = data.aws_route53_zone.ses[each.key].zone_id
      # verify_domain = true
      # verify_dkim   = true
      # iam_name      = "ses-example.com"

      # create_secret = true
      # description   = null
      # kms_key_id    = null
      # name          = "ses-${each.key}"
      # name_prefix   = ""
      # pass_version  = 1

      # notification_topic = {
      #   "Bounce" = {
      #     # topic_arn = "" # Default: sns_topic_alarms_notifications
      #     # include_original_headers = true # Default: true
      #   }
      #   # "Compliant" = {}
      #   # "Delivery"  = {}
      # }

      # default_sns_topic_name = "sns-topic-name" # Default: "${local.common_name}-alarms"
    }
    # "example.com" = {
    #   # zone_id       = data.aws_route53_zone.ses[each.key].zone_id
    #   verify_domain = false
    #   verify_dkim   = false
    #   # iam_name      = "ses-example.com"

    #   # create_secret = true
    #   # description   = null
    #   # kms_key_id    = null
    #   # name          = "ses-${each.key}"
    #   # name_prefix   = ""
    #   # pass_version  = 1
    # }
  }

  ses_defaults = var.ses_defaults
}