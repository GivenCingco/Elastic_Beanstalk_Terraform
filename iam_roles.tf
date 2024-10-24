/* =============== Elastic Beanstalk EC2 Role ===============*/


# Create IAM Role for Elastic Beanstalk EC2 instances
resource "aws_iam_role" "eb_instance_role" {
  name = "aws-elasticbeanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the Elastic Beanstalk Managed Policy to the Role
resource "aws_iam_role_policy_attachment" "eb_instance_web_tier_policy" {
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "eb_instance_worker_tier_policy" {
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_role_policy_attachment" "eb_instance_MulticontainerDocker_policy" {
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_instance_profile" "eb_instance_profile" {
  name = aws_iam_role.eb_instance_role.name
  role = aws_iam_role.eb_instance_role.name
}

/* =============== Elastic Beanstalk Service Role ===============*/

# Create Service Role for Elastic Beanstalk
resource "aws_iam_role" "eb_service_role" {
  name = "aws-elasticbeanstalk-flask-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the Elastic Beanstalk Managed Policy to the Role
# resource "aws_iam_role_policy_attachment" "eb_service_BasicHealth_policy" {
#   role       = aws_iam_role.eb_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkBasicHealth"
# }

resource "aws_iam_role_policy_attachment" "eb_service_ManagedUpdates_policy" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}

resource "aws_iam_instance_profile" "eb_service_profile" {
  name = aws_iam_role.eb_service_role.name
  role = aws_iam_role.eb_service_role.name
}