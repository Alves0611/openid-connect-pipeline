provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "ManagedBy" = "Terraform"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "creative-raccoon-tfstate"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
