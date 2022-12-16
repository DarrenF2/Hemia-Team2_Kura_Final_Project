# Hemia

### Welcome to the Hemia Application Repository! This repository is dedicated to explaining what the Hemia Application is and what its used for. 
<br>

## What Is Hemia?
**Hemia is an application primarily to help doctors**. A doctors' responsibility is to take care of patients and collect any information that is needed to be analyzed to identify and resolve any potential problems a patient can have. However, it may be problematic for a doctor to take care of patients and also analyze patient data in a limited amount of time. **The Hemia application is where doctors can make an account to upload their patient information for lab technicians to analyze the data and send it back to the doctors to help their work.**    
<br>

## How does the Hemia Application work?
The Hemia application can be used by doctors and lab technicians. When accessing the application, first an account must be created. The two options to choose from is to make a doctors account or a lab technicians account. When making either a doctor or lab technician account, both asks for your credentials and work identification to approve of your identity and job status.  
<br>

## Technologies used to create Hemia
The following technologies were used to create Hemia: <br>
* PHP - Backend scripting language to create Hemia
* HTML, CSS, JavaScript - Frontend scripting languages to create Hemia
* Docker - Create an image of the application locally
* AWS
  * RDS, MySQL - Database to enable login authentication and storing files
  * CodePipeline - CI/CD services that checks for recent updates and errors to help publish the application securely onto the web
  * Elastic Beanstalk - Publish the application onto the web
* Terraform - Provision AWS resources quickly
* CircleCI - Reads Terraform latest commands or changes in real-time to deploy or update AWS infrastructure  
<br>

## Operate the Hemia Application
To use Hemia, follow the steps shown below:
1. Access the Hemia url
2. Make either a doctor or lab technician account
* As a doctor:
  * See your current patient list
  * Upload files
  * Check back when your files are sent back
* As a lab techinician:
  * See available files sent to you from doctors
  * Review the files and send the results back to the doctors
<br>

### How to make a Doctor's account:
1. Register
<html>
     <h1>
        <img style="float: center;" src=/pictures/image.png width="1000" />
     </h1>
</html>

2. Sign-in
<html>
     <h1>
        <img style="float: center;" src=/pictures/image2.png width="1000" />
     </h1>
</html>

3. See your current patients
<html>
     <h1>
        <img style="float: center;" src=/pictures/image3.png width="1000" />
     </h1>
</html>

# Terraform

## Building a Terraform template

First thing first, we need to tell Terraform the provider we want to use so create a `provider.tf` file:

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
```

Create an S3 bucket and upload the zip folder, `s3.tf`. If the app.zip folder is not in your working directory, you need to specify the path for the source then.

```terraform
resource "aws_s3_bucket" "eb_bucket" {
    bucket = "your-bucket-name"
}
resource "aws_s3_bucket_object" "eb_bucket_obj" {
    bucket = aws_s3_bucket.eb_bucket.id
    key = "beanstalk/app.zip"
    source = "app.zip"  
}
```

It's time to create an app and environment for it, `beanstalk.tf`. Application_version resource needs to be created as well as there is no way to specify the source code for the app environment (creating in the next block)

```terraform
resource "aws_elastic_beanstalk_application" "eb_app" {
  name  = "your-app-name"
  description = "simple php app"

}
resource "aws_elastic_beanstalk_application_version" "eb_app_ver" {
    bucket = aws_s3_bucket.eb_bucket.id
    key = aws_s3_bucket_object.eb_bucket_obj.id
    application = aws_elastic_beanstalk_application.eb_app.name
    name = "your-app-name-version-lable"

}
```
Let's create an environment for our app, `elb-env.tf`. The platform needs to be declared, for the PHP app, try to use the latest - 64bit Amazon Linux 2 v3.3.9 running PHP 8.0.

The setting section is to configure the app environment as per your needs, learn more

An instance profile setting is required to create this template as it gives permissions to beanstalk to create ec2 instances and more.

```terraform
resource "aws_elastic_beanstalk_environment" "tfenv" {

  name = "eb-tf-env"
  application = aws_elastic_beanstalk_application.eb_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.9 running PHP 8.0"
  description = "environment for flask app"
  version_label = aws_elastic_beanstalk_application_version.eb_app_ver.name

  setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name = "IamInstanceProfile"
      value = "aws-elasticbeanstalk-ec2-role"
  }

}
```

Now just deploy this Terraform and see its magic!

To deploy type the following commands in your terminal:
`terraform init` - to initialize terraform
`terraform plan` - to have reform review the tf files you created and display the actions and changes.
`terraform apply` - to execute those actions and changes desginated by the plan command.
if you make a mistake or you want to take teardown the terraform build, run `terraform destroy` to facilitate that.

Reference article by: Gurlal Sidhu [here](https://dev.to/gsidhu13/deploy-a-flask-app-to-aws-elastic-beanstalk-with-terraform-36n8)


## Monitoring and Generating Alerts
The Hemia application is also integrated with Slack to give alerts on the application's current status. When the application is currently running or undergo a change, Slack shows a notification of the Hemia application run state whether it has been successful or failed to deploy.   
<html>
     <h1>
        <img style="float: center;" src=/pictures/image5.png width="1000" />
     </h1>
</html>
# Hemia

### Welcome to the Hemia Application Repository! This repository is dedicated to explaining what the Hemia Application is and what its used for. 
<br>

## What Is Hemia?
**Hemia is an application primarily to help doctors**. A doctors' responsibility is to take care of patients and collect any information that is needed to be analyzed to identify and resolve any potential problems a patient can have. However, it may be problematic for a doctor to take care of patients and also analyze patient data in a limited amount of time. **The Hemia application is where doctors can make an account to upload their patient information for lab technicians to analyze the data and send it back to the doctors to help their work.**    
<br>

## How does the Hemia Application work?
The Hemia application can be used by doctors and lab technicians. When accessing the application, first an account must be created. The two options to choose from is to make a doctors account or a lab technicians account. When making either a doctor or lab technician account, both asks for your credentials and work identification to approve of your identity and job status.  
<br>

## Technologies used to create Hemia
The following technologies were used to create Hemia: <br>
* PHP - Backend scripting language to create Hemia
* HTML, CSS, JavaScript - Frontend scripting languages to create Hemia
* Docker - Create an image of the application locally
* AWS
  * RDS, MySQL - Database to enable login authentication and storing files
  * CodePipeline - CI/CD services that checks for recent updates and errors to help publish the application securely onto the web
  * Elastic Beanstalk - Publish the application onto the web
* Terraform - Provision AWS resources quickly
* CircleCI - Reads Terraform latest commands or changes in real-time to deploy or update AWS infrastructure  
<br>

## Operate the Hemia Application
To use Hemia, follow the steps shown below:
1. Access the Hemia url
2. Make either a doctor or lab technician account
* As a doctor:
  * See your current patient list
  * Upload files
  * Check back when your files are sent back
* As a lab techinician:
  * See available files sent to you from doctors
  * Review the files and send the results back to the doctors
<br>

### How to make a Doctor's account:
1. Register
<html>
     <h1>
        <img style="float: center;" src=/pictures/image.png width="1000" />
     </h1>
</html>

2. Sign-in
<html>
     <h1>
        <img style="float: center;" src=/pictures/image2.png width="1000" />
     </h1>
</html>

3. See your current patients
<html>
     <h1>
        <img style="float: center;" src=/pictures/image3.png width="1000" />
     </h1>
</html>

# Terraform

## Building a Terraform template

First thing first, we need to tell Terraform the provider we want to use so create a `provider.tf` file:

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
```

Create an S3 bucket and upload the zip folder, `s3.tf`. If the app.zip folder is not in your working directory, you need to specify the path for the source then.

```terraform
resource "aws_s3_bucket" "eb_bucket" {
    bucket = "your-bucket-name"
}
resource "aws_s3_bucket_object" "eb_bucket_obj" {
    bucket = aws_s3_bucket.eb_bucket.id
    key = "beanstalk/app.zip"
    source = "app.zip"  
}
```

It's time to create an app and environment for it, `beanstalk.tf`. Application_version resource needs to be created as well as there is no way to specify the source code for the app environment (creating in the next block)

```terraform
resource "aws_elastic_beanstalk_application" "eb_app" {
  name  = "your-app-name"
  description = "simple php app"

}
resource "aws_elastic_beanstalk_application_version" "eb_app_ver" {
    bucket = aws_s3_bucket.eb_bucket.id
    key = aws_s3_bucket_object.eb_bucket_obj.id
    application = aws_elastic_beanstalk_application.eb_app.name
    name = "your-app-name-version-lable"

}
```
Let's create an environment for our app, `elb-env.tf`. The platform needs to be declared, for the PHP app, try to use the latest - 64bit Amazon Linux 2 v3.3.9 running PHP 8.0.

The setting section is to configure the app environment as per your needs, learn more

An instance profile setting is required to create this template as it gives permissions to beanstalk to create ec2 instances and more.

```terraform
resource "aws_elastic_beanstalk_environment" "tfenv" {

  name = "eb-tf-env"
  application = aws_elastic_beanstalk_application.eb_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.9 running PHP 8.0"
  description = "environment for flask app"
  version_label = aws_elastic_beanstalk_application_version.eb_app_ver.name

  setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name = "IamInstanceProfile"
      value = "aws-elasticbeanstalk-ec2-role"
  }

}
```

Now just deploy this Terraform and see its magic!

To deploy type the following commands in your terminal:
`terraform init` - to initialize terraform
`terraform plan` - to have reform review the tf files you created and display the actions and changes.
`terraform apply` - to execute those actions and changes desginated by the plan command.
if you make a mistake or you want to take teardown the terraform build, run `terraform destroy` to facilitate that.

Reference article by: Gurlal Sidhu [here](https://dev.to/gsidhu13/deploy-a-flask-app-to-aws-elastic-beanstalk-with-terraform-36n8)


## Monitoring and Generating Alerts
The Hemia application is also integrated with Slack to give alerts on the application's current status. When the application is currently running or undergo a change, Slack shows a notification of the Hemia application run state whether it has been successful or failed to deploy.   
<html>
     <h1>
        <img style="float: center;" src=/pictures/image5.png width="1000" />
     </h1>
</html>



