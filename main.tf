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
# data "aws_ecs_task_definition" "hemia_task" {
#   task_definition = aws_ecs_task_definition.hemia_task.family
# }


# resource "aws_ecs_task_definition" "hemia_task" {
#   family                = "hemia_task"
#   container_definitions = "${file("task-definitions/service.json")}"
# }


# # AWS Security Group
# module "web_server_sg" {
#   source = "terraform-aws-modules/security-group/aws//modules/http-80"

#   name        = "hemia-web-server"
#   description = "Security group for web-server with HTTP ports open within VPC"
#   vpc_id      = "vpc-5f562d22"

#   ingress_cidr_blocks = ["10.10.0.0/16"]
# }


# # Target Group
  
# resource "aws_lb_target_group" "hemia-target" {
#   name        = "hemia-target-group"
#   port        = 8081
#   protocol    = "HTTP"
#   target_type = "ip"
#   vpc_id      = "vpc-5f562d22"
# }




