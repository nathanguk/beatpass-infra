#App Insights

# Create Application Insights
resource "azurerm_application_insights" "main" {
  name                = "${var.resource_name_prefix}-ai"
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "web"
  tags = var.tags
}
