terraform {
  backend "s3" {
    bucket         = "recipe-app-api-devops-tfstate-erik.vandam"
    key            = "recipe-app.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "recipe-app-api-devops-tfstate-lock"
  }
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.54.0"
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {}