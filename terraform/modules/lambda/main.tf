data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.source_path
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "${var.prefix}-lambda"
  role          = aws_iam_role.lambda.arn
  handler       = var.config.handler
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = var.config.runtime
  publish = true

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }
}

#resource "aws_lambda_alias" "lambda_alias" {
#  name             = "live"
#  description      = "The latest version"
#  function_name    = aws_lambda_function.lambda.arn
#  function_version = aws_lambda_function.lambda.version
#}