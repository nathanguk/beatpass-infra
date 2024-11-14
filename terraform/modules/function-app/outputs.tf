#Outputs

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "storage_account_id" {
  value = azurerm_storage_account.main.id
}

output "function_app_name" {
  value = azurerm_windows_function_app.main.name
}

output "function_app_id" {
  value = azurerm_windows_function_app.main.id
}

output "function_identity" {
  value = azurerm_windows_function_app.main.identity[0].principal_id
}