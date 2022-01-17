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

resource "aws_security_group_rule" "hemia_security" {
  type              = "ingress"
  from_port         = 80
  to_port           = 8081
  protocol          = "tcp"
  
  ipv4_cidr_blocks  = [aws_vpc.hemia_security.ipv4_cidr_block]
  security_group_id = "sg-123-hemia"
}






