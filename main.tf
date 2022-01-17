terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


#Test EC2
resource "aws_instance" "myweb" {
  ami           = "ami-0e763a959ec839f5e"
  instance_type = "t2.micro"
