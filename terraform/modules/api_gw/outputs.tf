output "url" {
  value = join("", [aws_api_gateway_stage.stage.invoke_url, aws_api_gateway_resource.resource.path])
}