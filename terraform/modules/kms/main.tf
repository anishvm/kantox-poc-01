resource "aws_kms_key" "kms" {
  description             = "KMS key for DB"
  enable_key_rotation = true
}

resource "aws_kms_key_policy" "policy" {
  key_id = aws_kms_key.kms.id
  policy = var.policy
}

resource "aws_kms_alias" "a" {
  name          = "alias/${var.prefix}"
  target_key_id = aws_kms_key.kms.key_id
}