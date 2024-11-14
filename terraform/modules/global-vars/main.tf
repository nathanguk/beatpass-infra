data "azurerm_client_config" "current" { }

data "azuread_user" "current_user" {
  object_id = data.azurerm_client_config.current.object_id
}