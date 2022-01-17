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

# Creare ECR Repo
resource "aws_ecr_repository" "create_hemia_ecr_repo" {
  name = "hemia_ecr_repo"
}
  
# Create ECS Cluster
resource "aws_ecs_cluster" "create_hemia_cluster" {
  name = "hemia-cluster"
}


