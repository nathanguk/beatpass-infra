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

variable "azurerm_cosmosdb_database_name" {
  description = "The CosmosDB database name"
  type        = string
}

variable "b2c_client_id" {
  description = "The B2C Client Id"
  type        = string
}

variable "b2c_extensions_app_id" {
  description = "The B2C Extensions App Id"
  type        = string
}

variable "b2c_issuer" {
  description = "The B2C Issuer Uri"
  type        = string
  
}
