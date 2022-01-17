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

# Create ECR Repo
# resource "aws_ecr_repository" "create_hemia_ecr_repo" {
#   name = "hemia_ecr_repo"
# }
  
# # Create ECS Cluster
# resource "aws_ecs_cluster" "create_hemia_cluster" {
#   name = "hemia-cluster"
# }


# AWS Task Definition

# Simply specify the family to find the latest ACTIVE revision in that family.
data "aws_ecs_task_definition" "hemia_task" {
  task_definition = aws_ecs_task_definition.hemia_task.family
}


resource "aws_ecs_task_definition" "hemia_task" {
  family                = "hemia_task"
  container_definitions = "${file("task-definitions/service.json")}"
}


# AWS Security Group

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv4_cidr_blocks = [aws_vpc.main.ipv4_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv4_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}






