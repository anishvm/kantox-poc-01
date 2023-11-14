variable "default_tags" {}

variable "region" {}

variable "prefix" {
  validation {
    condition = var.prefix != null && var.prefix != ""
    error_message = "The prefix cannot be blank"
  }
}

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

variable "admin" {
  validation {
    condition = var.admin != null && var.admin != ""
    error_message = "The admin user cannot be blank"
  }
}