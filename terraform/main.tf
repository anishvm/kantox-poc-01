module "kms" {
  source = "./modules/kms"
  policy = data.aws_iam_policy_document.kms.json
  prefix = var.prefix
}

module "db" {
  source = "./modules/db"
  config = var.db_config
  kms_key_arn = module.kms.kms_key_arn
  prefix = var.prefix
}

module "lambda" {
  source = "./modules/lambda"
  config = var.lambda_config
  policy = data.aws_iam_policy_document.lambda.json
  prefix = var.prefix
  source_path = "../lambda_function.py"
  environment_variables = {
    db_arn = module.db.db_arn
  }
}

module "api" {
  source = "./modules/api_gw"
  lambda_function_name = module.lambda.lambda_function_name
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
  prefix = var.prefix
}