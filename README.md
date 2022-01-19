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
* HTML - Frontend scripting language to create Hemia
* Docker - Create an image of the application locally
* AWS
  * RDS, MySQL - Database to enable login authentication and storing files
  * ECR - Upload the application image to AWS 
  * ECS - Use the ECR image to deploy it on this service 
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

## Monitoring and Generating Alerts
