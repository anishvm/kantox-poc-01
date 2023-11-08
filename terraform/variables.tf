variable "default_tags" {}

variable "region" {}

variable "prefix" {}

variable "db_config" {
  type = object({
    hash_key = string
    attributes = list(map(string))
  })
}

variable "lambda_config" {
  type = object({
    runtime = string
    handler = string
  })
}

variable "admin" {}