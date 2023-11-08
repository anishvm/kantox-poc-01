output "db_arn" {
  value = aws_dynamodb_table.dynamodb-table.arn
}

output "table_name" {
  value = aws_dynamodb_table.dynamodb-table.name
}