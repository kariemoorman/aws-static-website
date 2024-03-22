variable "aws_default_region" {
  type        = string
  default     = "us-east-1"
  description = "Default AWS region"
}

variable "domain_name" {
  type        = string
  default     = "www.domain.com"
  description = "Custom domain name"
}

variable "simple_domain_name" {
  type        = string
  default     = "domain.com"
  description = "Simple custom domain name"
}