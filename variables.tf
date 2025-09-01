/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* SES | Variable Definition                                            */
/*----------------------------------------------------------------------*/
variable "ses_parameters" {
  type        = any
  description = "SES parameteres to configure SES module"
  default     = {}
}

variable "ses_defaults" {
  type        = any
  description = "SES defaults parameteres to configure ses module"
  default     = {}
}