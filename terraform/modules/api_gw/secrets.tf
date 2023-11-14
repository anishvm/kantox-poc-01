resource "aws_secretsmanager_secret" "main" {
  name = "${var.prefix}-secret"
  kms_key_id = var.kms_key_id
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode({
    api_key = aws_api_gateway_api_key.api.value
  })
}