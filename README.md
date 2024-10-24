
# Elastic Beanstalk Flask Application
Overview
This project is a simple Flask application deployed on AWS Elastic Beanstalk. It serves as a demonstration of deploying web applications using Elastic Beanstalk's Platform as a Service (PaaS) features, providing an easy way to manage the application lifecycle, including deployment, scaling, and monitoring.

## Features
Flask Framework: Lightweight and flexible web framework for building web applications.
Elastic Beanstalk Deployment: Automates the deployment process to AWS, including provisioning and managing the underlying infrastructure.
VPC Integration: Configured to run within a custom VPC, ensuring secure and controlled access to resources.
Security Group Management: Implemented custom security groups to control inbound and outbound traffic.
S3 Bucket for Storage: Utilizes Amazon S3 for storing application files and assets.
Prerequisites
Before deploying the application, ensure you have the following:

An AWS account with appropriate permissions.
Terraform installed for infrastructure as code (IAC) management.
The AWS CLI configured with your credentials.
Basic understanding of Flask and AWS Elastic Beanstalk.
