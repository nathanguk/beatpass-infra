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

variable "instrumentation_key" {
  description = "The Application Insights Instrumentation Key value"
  type        = string
}

variable "keyvault_url" {
  description = "The Keyvault URL value"
  type        = string
}

variable "keyvault_id" {
  description = "The Keyvault Id value"
  type        = string
}

variable "tenant_id" {
  description = "The tenant id value"
  type        = string
}

variable "current_user_id" {
  description = "The current user id value"
  type        = string
}

variable "azurerm_cosmosdb_account_name" {
  description = "The CosmosDB account name"
  type        = string
}


