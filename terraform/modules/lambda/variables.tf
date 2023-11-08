variable "prefix" {}

variable "source_path" {}

variable "config" {
  type = object({
    runtime = string
    handler = string
  })
}

variable "environment_variables" {
  type = map(string)
  default = {}
}

variable "policy" {}