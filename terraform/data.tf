data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "kms" {
  statement {
    effect = "Allow"
    sid = "EnableAdminManagement"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.admin}"]
    }
    actions = ["kms:*"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    sid = "AllowDynamoDB"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
      ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values   = ["dynamodb.${data.aws_caller_identity.current.account_id}.amazonaws.com"]
      variable = "kms:ViaService"
    }
  }
  statement {
    effect = "Allow"
    sid = "AllowLambdaRole"
    principals {
      type        = "AWS"
      identifiers = [module.lambda.lambda_role_arn]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
      ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    effect = "Allow"
    sid = "CloudWatchLogging"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    effect = "Allow"
    sid = "DynamoDB"
    actions = [
				"dynamodb:BatchGetItem",
				"dynamodb:GetItem",
				"dynamodb:Query",
				"dynamodb:Scan",
				"dynamodb:BatchWriteItem",
				"dynamodb:PutItem",
				"dynamodb:UpdateItem"
			]
    resources = [module.db.db_arn]
  }
}