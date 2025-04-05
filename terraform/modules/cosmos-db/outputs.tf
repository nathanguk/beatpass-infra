#Outputs

output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.main.name
}

output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.main.id
}

output "cosmosdb_database_name" {
  value = azurerm_cosmosdb_sql_database.main.name
}