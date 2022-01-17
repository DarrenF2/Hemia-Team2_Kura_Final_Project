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

resource "aws_ecs_task_definition" "make_hemia_task" {
  container_definitions = <<DEFINITION
  [
    {
      "name": "hemia-task"
      "image": "${aws_ecr_repository.create_hemia_ecr_repo.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8081,
          "hostPort": 8081
        }
       ],
      "memory": 512,
      "cpu": 256
    }
  ]
  
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 2048
  cpu                      = 1024
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}




