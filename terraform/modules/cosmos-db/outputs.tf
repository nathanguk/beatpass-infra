#Outputs

output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.main.name
}

output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.main.id
}