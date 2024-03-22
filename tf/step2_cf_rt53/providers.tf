# Provider & Region
provider "aws" {
  region = var.aws_default_region

  default_tags {
    tags = {
      terraform = true
    }
  }
}

# Provider for ACM
provider "aws" {
  region = "us-east-1"
  alias  = "use_default_region"
}