resource "aws_elastic_beanstalk_application" "welxome-6_app" {
  name  = "welxome-6-app"
  description = "welxome-2-project"

}
resource "aws_elastic_beanstalk_application_version" "welxome-6_app_ver" {
    bucket = aws_s3_bucket.hemia1_bucket.id
    key = aws_s3_bucket_object.eb_bucket_obj.id
    application = aws_elastic_beanstalk_application.welxome-6_app.name
    name = "welxome-tf-app-version-lable"

}