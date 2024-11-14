#Variables

variable "tenant_id" {
  description = "The tenant id value"
  type        = string
}

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

variable "current_user_id" {
  description = "The current user id value"
  type        = string
}