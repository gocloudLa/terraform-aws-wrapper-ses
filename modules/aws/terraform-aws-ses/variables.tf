variable "create_domain" {
  type        = bool
  description = "If provided the module will create a SES domain."
  default     = true
}

variable "domain" {
  description = "The domain to create the SES identity for."
  type        = string
}

variable "zone_id" {
  type        = string
  description = "Route53 parent zone ID. If provided (not empty), the module will create Route53 DNS records used for verification"
  default     = ""
}

variable "verify_domain" {
  type        = bool
  description = "If provided the module will create Route53 DNS records used for domain verification."
  default     = false
}

variable "verify_dkim" {
  type        = bool
  description = "If provided the module will create Route53 DNS records used for DKIM verification."
  default     = false
}

variable "enable_spf_domain" {
  type        = bool
  description = "If provided the module will create Route53 DNS records used for SPF."
  default     = false
}

#Module      : SMTP IAM USER
#Description : Terraform smtp Iam user module variables.
variable "iam_name" {
  type        = string
  default     = ""
  description = "IAM username."
}

########################################
# General vars
########################################
variable "create_secret" {
  default     = true
  description = "If false, this module does nothing (since tf doesn't support conditional modules)"
  type        = bool
}

variable "description" {
  default     = ""
  description = "Description to add to Secret"
  type        = string
}

variable "kms_key_id" {
  default     = null
  description = "Optional. The KMS Key ID to encrypt the secret. KMS key arn or alias can be used."
}

variable "name" {
  default     = ""
  description = "Name (omit to use name_prefix)"
  type        = string
}

variable "name_prefix" {
  default     = "terraform"
  description = "Name Prefix (not used if name specified)"
  type        = string
}

variable "pass_version" {
  default     = 1
  description = "Password version. Increment this to trigger a new password."
  type        = number
}

variable "recovery_window_in_days" {
  default     = 30
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret."
  type        = number
}

variable "tags" {
  default     = {}
  description = "Tags to add to supported resources"
  type        = map(string)
}

variable "notification_topic" {
  default     = {}
  description = "Map of SES notification topic configurations"
  type        = map(any)
}

variable "default_sns_topic_name" {
  type        = string
  description = ""
  default     = ""
}