variable "prefix" {}

variable "kms_key_arn" {}

variable "config" {
  type = object({
    hash_key = string
    attributes = list(map(string))
  })
}