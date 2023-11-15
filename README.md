# Architecture Overview

Refer docs for more information.

![Alt text](docs/AWS-Architecture.png?raw=true)


## 

## Prerequisites
- AWS CLI v2
- Terraform

## Getting Started

### Creating Backend

Creates an S3 bucket and related resources to be used in the terraform modules. 
Update the stack name & parameter values in stack_config.json file. All parameters are mandatory.

```bash
aws cloudformation create-stack  --template-body file://backend.yml --cli-input-json file://stack_config.json

#Note down the outputs of the stack 
aws cloudformation describe-stacks --stack-name <kantox-poc>
```

### Creating App Stack

Update the details in terraform/backend.yml file using the outputs of CloudFormation stack.
Update the variable "**admin**" in terraform/environments/poc.tfvars file with an IAM username and password in the AWS account.  

Note: Use workspaces and create new .tfvars files to create multiple environments.
```bash
cd terraform
terraform init
terraform plan -var-file environments/poc.tfvars
terraform apply -var-file environments/poc.tfvars
```

### Testing API

The api gateway endpoint is Terraform output "**url**". Get the API key from the AWS secrets manager.
Use Postman or something similar and POST request to the API. 
Scan the items in DynamoDB table to verify that items are created/updated.

### Example Input
```bash
{
    "12345": {
        "name": "Mace Windu",
        "planet": "Haruun Kal",
        "power_level": 87
    },
    "54832": {
        "name": "Obi-Wan Kenobi",
        "planet": "Stewjon",
        "power_level": 85
    },
    "78965": {
        "name": "Rey",
        "planet": "Jakku",
        "power_level": 75
    },
    "98721": {
        "name": "Yoda",
        "planet": "Dagobah",
        "power_level": 90
    }
}
```