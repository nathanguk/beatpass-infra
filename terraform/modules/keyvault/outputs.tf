#Outputs

output "keyvault_url" {
  value = azurerm_key_vault.main.vault_uri
  sensitive = true
}

output "keyvault_id" {
  value = azurerm_key_vault.main.id
  sensitive = true
}