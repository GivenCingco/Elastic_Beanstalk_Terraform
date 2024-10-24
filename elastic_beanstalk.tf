

# Create S3 bucket for Python Flask app
resource "aws_s3_bucket" "eb_bucket" {
  bucket = "enes-eb-nextjs-app-0123" # Name of S3 bucket to create for Flask app deployment needs to be unique 
}

# Define App files to be uploaded to S3
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.eb_bucket.id
  key    = "ElasticBeanStalk/flask_app.zip"
  source = "flask_app.zip"
}
# Define Elastic Beanstalk application
resource "aws_elastic_beanstalk_application" "eb_app" {
  name        = "flask-eb-tf-app"  # Name of the Elastic Beanstalk application
  description = "simple flask app" # Description of the Elastic Beanstalk application
}

# Create Elastic Beanstalk environment for application with defining environment settings
resource "aws_elastic_beanstalk_application_version" "eb_app_ver" {
  bucket      = aws_s3_bucket.eb_bucket.id                    # S3 bucket name
  key         = aws_s3_object.object.key                      # S3 key path 
  application = aws_elastic_beanstalk_application.eb_app.name # Elastic Beanstalk application name
  name        = "enes-eb-tf-app-version-lable"                # Version label for Elastic Beanstalk application
}

#Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "tfenv" {
  name                = "dev-flask-env"
  application         = aws_elastic_beanstalk_application.eb_app.name             # Elastic Beanstalk application name
  solution_stack_name = "64bit Amazon Linux 2023 v4.2.0 running Python 3.12"       # Define current version of the platform
  description         = "environment for Flask app"                              # Define environment description
  version_label       = aws_elastic_beanstalk_application_version.eb_app_ver.name # Define version label

  setting {
    namespace = "aws:autoscaling:launchconfiguration" # Define namespace
    name      = "IamInstanceProfile"                  # Define name
    value     = "aws-elasticbeanstalk-ec2-role"       # Define value
  }
}

