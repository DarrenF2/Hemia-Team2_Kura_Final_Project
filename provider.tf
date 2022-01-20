terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket = "hemia-app-tfstate"
    key    = "terraform/hemia/terraform.tfstate"
    region = "us-east-1"
  }


  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
   region  = "us-east-1"
}

