variable "aws_default_region" {
  type        = string
  default     = "us-east-1"
  description = "Default AWS region"
}

variable "gh-actions-username" {
    type        = string
    default     = "github-actions-user"
    description = "Github Actions Username"
}

variable "aws-s3" {
    type        = string
    default     = "arn:aws:s3:::<s3_bucket_name>"
    description = "Github Actions Username"


}

variable "aws-repo-name" {
    type        = string
    default     = "arn:aws:codecommit:<region>:<aws_account_id>:<s3_bucket_name>"
    description = "Github Actions Username"
}