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
resource "aws_ami_from_instance" "example" {
  name = "terraform-example"
  source_instance_id = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
}
