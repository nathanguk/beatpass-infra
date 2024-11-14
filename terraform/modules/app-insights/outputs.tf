#Outputs

output "application_insights_key" {
  value = azurerm_application_insights.main.instrumentation_key
  sensitive = true
}
