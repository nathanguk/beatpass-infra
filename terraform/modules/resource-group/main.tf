# Resource Group Module

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
  tags     = var.tags
}