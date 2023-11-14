terraform {
  backend "s3" {
    bucket         = ""
    dynamodb_table = ""
    key            = "terraform.tfstate"
    encrypt        = true
    region         = ""
    role_arn       = ""
    kms_key_id = ""
  }
}