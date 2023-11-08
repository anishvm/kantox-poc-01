resource "aws_dynamodb_table" "dynamodb-table" {
  name                        = "${var.prefix}-db"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = var.config.hash_key
  deletion_protection_enabled = true

  dynamic "attribute" {
    for_each = var.config.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms_key_arn
  }
}