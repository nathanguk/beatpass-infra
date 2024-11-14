#Variables

variable "resource_name_prefix" {
  description = "The resource name prefix value"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The resource location value"
  type        = string
}

variable "tags" {
  description = "The resource tags value"
  type        = map(any)
}