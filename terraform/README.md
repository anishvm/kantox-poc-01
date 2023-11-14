# Terraform Module for APP

This project contains the necessary CloudFormation template to create the remote backend in S3 and 
the Terraform modules & lambda function code.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

  - [Prerequisites](#prerequisites)
  - [Create Backend](#create-backend)
  - [Create Stack](#create-stack)
  - [Test API](#test-api)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Prerequisites
- AWS CLI v2
- Terraform

## Create Backend
Update the stack name & parameter values in stack_config.json file. All parameters are mandatory.
```bash
aws cloudformation create-stack  --template-body file://backend.yml --cli-input-json file://stack_config.json

#Note down the outputs of the stack 
aws cloudformation describe-stacks --stack-name <kantox-poc>
```

## Create Stack

Update the details in terraform/backend.yml file using the outputs of CloudFormation stack.
Update the variable "**admin**" in terraform/environments/poc.tfvars file with an IAM username and password in the AWS account.  

Note: Use workspaces and create new tfvars files to create multiple environments.
```bash
cd terraform
terraform init
terraform plan -var-file environments/poc.tfvars
terraform apply -var-file environments/poc.tfvars
```

## Test API

The api gateway endpoint is Terraform output "**url**". Get the API key from the AWS secrets manager.
Use Postman or something similar and POST request to the API. 
Scan the items in DynamoDB table to verify that items are created/updated.