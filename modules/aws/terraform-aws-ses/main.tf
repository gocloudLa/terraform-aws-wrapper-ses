#Module      : DOMAIN
#Description : Terraform module to create domain
resource "aws_ses_domain_identity" "ses_domain" {
  count = var.create_domain ? 1 : 0

  domain = var.domain
}

resource "aws_route53_record" "amazonses_verification_record" {
  count = var.create_domain && var.verify_domain ? 1 : 0

  zone_id = var.zone_id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [join("", aws_ses_domain_identity.ses_domain.*.verification_token)]
}

#Module      : DKIM RECORD
#Description : Terraform module to create record of DKIM for domain
resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  count = var.create_domain ? 1 : 0

  domain = join("", aws_ses_domain_identity.ses_domain.*.domain)
}

resource "aws_route53_record" "amazonses_dkim_record" {
  count = var.create_domain && var.verify_dkim ? 3 : 0

  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.ses_domain_dkim.0.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.ses_domain_dkim.0.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

#Module      : SPF RECORD
#Description : Terraform module to create record of SPF for domain
resource "aws_route53_record" "spf_domain" {
  count   = var.create_domain && var.enable_spf_domain ? 1 : 0
  zone_id = var.zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}

###SMTP USER#######
resource "aws_iam_user" "default" {
  count = var.iam_name != "" ? 1 : 0
  name  = var.iam_name
}

resource "aws_iam_access_key" "default" {
  count = var.iam_name != "" ? 1 : 0
  user  = join("", aws_iam_user.default.*.name)
}

resource "aws_iam_user_policy" "default" {
  count  = var.iam_name != "" ? 1 : 0
  name   = var.iam_name
  user   = join("", aws_iam_user.default.*.name)
  policy = data.aws_iam_policy_document.allow_iam_name_to_send_emails.json
}


data "aws_iam_policy_document" "allow_iam_name_to_send_emails" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

###Secret Manager for SMTP USER#######
resource "aws_secretsmanager_secret" "secret" {
  count                   = var.create_secret ? 1 : 0
  name                    = var.name == "" ? null : var.name
  name_prefix             = var.name == "" ? var.name_prefix : null
  description             = var.description
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "secret_val" {
  count     = var.create_secret ? 1 : 0
  secret_id = aws_secretsmanager_secret.secret[0].id
  secret_string = jsonencode({
    AWS_SES_SOURCE_ARN = "${aws_ses_domain_identity.ses_domain.0.arn}"
    SMTP_ADDRESS       = "email-smtp.${data.aws_region.current.region}.amazonaws.com"
    SMTP_AUTH          = "plain"
    SMTP_DOMAIN        = var.domain
    SMTP_PASSWORD      = "${aws_iam_access_key.default.0.ses_smtp_password_v4}"
    SMTP_PORT          = 587
    SMTP_REGION        = "${data.aws_region.current.region}"
    SMTP_SECRET        = "${aws_iam_access_key.default.0.secret}"
    SMTP_USERNAME      = "${aws_iam_access_key.default.0.id}"
  })
}

locals {
  for_each = try(var.notification_topic, {})

  notification_default_topic = length(var.notification_topic) == 0 ? 0 : anytrue([
    for _, values in var.notification_topic : (
      try(values.topic_arn, "") == ""
    )
  ]) ? 1 : 0
}


data "aws_sns_topic" "default" {
  count = local.notification_default_topic
  name  = var.default_sns_topic_name
}

resource "aws_ses_identity_notification_topic" "this" {
  for_each = var.notification_topic

  notification_type        = each.key
  identity                 = aws_ses_domain_identity.ses_domain[0].domain
  topic_arn                = try(each.value.topic_arn, data.aws_sns_topic.default[0].arn)
  include_original_headers = try(each.value.include_original_headers, true)
}
