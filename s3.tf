resource "aws_s3_bucket" "hemia_bucket" {
    bucket = "hemia-test-01"
versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "eb_bucket_obj" {
    bucket = aws_s3_bucket.hemia_bucket.id
    key = "beanstalk/app.zip"
    source = "app.zip"  
}
