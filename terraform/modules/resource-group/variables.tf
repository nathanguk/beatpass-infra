#Variables

variable "resource_name_prefix" {
  description = "The resource group name prefix value"
  type        = string
}

variable "location" {
  description = "The resource group location value"
  type        = string
}

variable "tags" {
  description = "The resource group tags value"
  type        = map(any)
}
