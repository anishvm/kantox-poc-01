terraform {
  backend "s3" {
    bucket         = "kantox-poc-1-833606799879"
    dynamodb_table = "kantox-poc-1-833606799879"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "eu-west-2"
    role_arn       = "arn:aws:iam::833606799879:role/kantox-poc-1"
    kms_key_id = "arn:aws:kms:eu-west-2:833606799879:key/ca0130ad-3137-4d62-9707-d9fee0b35625"
  }
}