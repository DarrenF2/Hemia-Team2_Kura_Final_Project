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
  
resource "aws_instance" "ubuntu" {
  ami           = "ami-013f17f36f8b1fefb"
  instance_type = "t2.micro"
#   subnet_id     = ""
}
