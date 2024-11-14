#Keyvault

# Create Keyvault
resource "azurerm_key_vault" "main" {
  name                            = "${var.resource_name_prefix}-kv"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku_name                        = "standard"
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = true
  tags                            = var.tags
}

resource "azurerm_role_assignment" "certificate" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.current_user_id
}