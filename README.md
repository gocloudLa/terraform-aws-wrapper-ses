# Standard Platform - Terraform Module 🚀🚀
<p align="right"><a href="https://partners.amazonaws.com/partners/0018a00001hHve4AAC/GoCloud"><img src="https://img.shields.io/badge/AWS%20Partner-Advanced-orange?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS Partner"/></a><a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-green?style=for-the-badge&logo=apache&logoColor=white" alt="LICENSE"/></a></p>

Welcome to the Standard Platform — a suite of reusable and production-ready Terraform modules purpose-built for AWS environments.
Each module encapsulates best practices, security configurations, and sensible defaults to simplify and standardize infrastructure provisioning across projects.

## 📦 Module: Terraform SES Email Module
<p align="right"><a href="https://github.com/gocloudLa/terraform-aws-wrapper-ses/releases/latest"><img src="https://img.shields.io/github/v/release/gocloudLa/terraform-aws-wrapper-ses.svg?style=for-the-badge" alt="Latest Release"/></a><a href=""><img src="https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-wrapper-ses.svg?style=for-the-badge" alt="Last Commit"/></a><a href="https://registry.terraform.io/modules/gocloudLa/wrapper-ses/aws"><img src="https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Registry"/></a></p>
The Terraform wrapper for SES simplifies the configuration of the SMTP Service in the AWS cloud. This wrapper functions as a predefined template, facilitating the creation and management of SES by handling all technical details.

### ✨ Features

- 📧 [SES Notifications and Logging](#ses-notifications-and-logging) - Enables Amazon SES notifications and logging for your domains.




## 🚀 Quick Start
```hcl
ses_parameters = {
        "example.com" = {
        }
    }
```


## 🔧 Additional Features Usage

### SES Notifications and Logging
This allows you to configure Amazon SES to send notifications for events such as Bounce, Complaint, or Delivery. 
You can define custom SNS topics for each type of notification and optionally include original email headers. 


<details><summary>Configuration Code</summary>

```hcl
ses_parameters = {
  "${local.zone_public}" = {
    notification_topic = {
      "Bounce" = {
        # topic_arn = "" # Default: sns_topic_alarms_notifications
        # include_original_headers = true # Default: true
      }
      # "Complaint" = {}
      # "Delivery"  = {}
    }

    # default_sns_topic_name = "sns-topic-name" # Default: "${local.common_name}-alarms"
  }
}
```


</details>




## 📑 Inputs
| Name               | Description                                                                               | Type     | Default                                          | Required |
| ------------------ | ----------------------------------------------------------------------------------------- | -------- | ------------------------------------------------ | -------- |
| zone_id            | Route53 parent zone ID. The module will create Route53 DNS records used for verification. | `string` | `data.aws_route53_zone.ses[example.com].zone_id` | no       |
| verify_domain      | If provided, the module will create Route53 DNS records used for domain verification.     | `bool`   | `true`                                           | no       |
| verify_dkim        | If provided, the module will create Route53 DNS records used for DKIM verification.       | `bool`   | `true`                                           | no       |
| iam_name           | IAM username.                                                                             | `string` | `"ses-example.com"`                              | no       |
| create_secret      | Controls whether to create a secret manager to store users created by SES.                | `bool`   | `true`                                           | no       |
| description        | Description to add to the secret.                                                         | `string` | `null`                                           | no       |
| kms_key_id         | Optional. The KMS Key ID to encrypt the secret. Can use KMS key ARN or alias.             | `string` | `null`                                           | no       |
| name               | Name (omit to use name_prefix).                                                           | `string` | `"ses-example.com"`                              | no       |
| name_prefix        | Name Prefix (not used if name specified).                                                 | `string` | `""`                                             | no       |
| pass_version       | Password version. Increment this to trigger a new password.                               | `string` | `"1"`                                            | no       |
| notification_topic | Map of SES notification topic configurations.                                             | `map`    | `"{}"`                                           | no       |







## ⚠️ Important Notes
To enable Amazon SES, you first need to set up the domain. After the domain shows a verified status, you must open a support case to request the removal of the sandbox limitation for the region. In that case, you should submit the following text:
```hcl
Use case description: We will use Amazon SES for sending emails to our future clients, the emails will consist of register, notification and transactional emails. 
We will limit our emails only to customers and we will have a use case of 10 to 20 emails per day due to being for test purposes.
Mail Type: TRANSACTIONAL
The correct URL is: https://example.com/
```



---

## 🤝 Contributing
We welcome contributions! Please see our contributing guidelines for more details.

## 🆘 Support
- 📧 **Email**: info@gocloud.la
- 🐛 **Issues**: [GitHub Issues](https://github.com/gocloudLa/issues)

## 🧑‍💻 About
We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.
- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

## 📄 License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details. 