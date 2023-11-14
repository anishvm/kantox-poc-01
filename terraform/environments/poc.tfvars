# Default tags to be attached to all the resources
default_tags = {
  Terraform   = "True"
  Environment = "POC"
}

#AWS region where the stack will be created
region = "eu-west-2"

#Prefix to be attached in the name of  all the resources. Cannot be blank
prefix = "kantox-poc"

# DynamoDB configuration
db_config = {
  hash_key = "Id"
  attributes = [
    {
      name = "Id"
      type = "N"
    }
  ]
}

# Lambda function configuration
lambda_config = {
  runtime = "python3.11"
  handler = "lambda_function.lambda_handler"
}

# Name of the IAM admin user who can manage the kms key. Cannot be blank
admin = "dfgdg"