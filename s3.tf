# Create a public s3 bucket for storing the application files
resource "aws_s3_bucket" "hemia1_bucket" {
    bucket = "hemia-test-02"
    acl    = "public-read"
    policy = file("policy.json")
versioning {
    enabled = true
  }
}

# Upload application zipfile for source repo to s3 bucket
resource "aws_s3_bucket_object" "eb_bucket_obj" {
    bucket = aws_s3_bucket.hemia1_bucket.id
    key = "beanstalk/app.zip"
    source = "app.zip"  
}

# Create S3 bucket to hold terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "hemia-tfstate"
  # Enable versioning so we can see the full revision history of our
  # state files
  force_destroy = true
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}