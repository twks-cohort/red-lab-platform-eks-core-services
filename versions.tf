terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twks-cohort"
    workspaces {
      prefix = "red-lab-platform-eks-core-services-"
    }
  }
}

provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn     = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_assume_role}"
    session_name = "red-lab-platform-eks-core-services"
  }

  default_tags {
    tags = {
      env      = var.cluster_name
      cluster  = var.cluster_name
      pipeline = "red-lab-platform-eks-core-services"
    }
  }
}
