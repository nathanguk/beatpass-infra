#Function App

data "azurerm_subscription" "main" {}

data "azurerm_cosmosdb_account" "main" {
  name                = var.azurerm_cosmosdb_account_name
  resource_group_name = var.resource_group_name
}

# Create Function App Storage Account
resource "azurerm_storage_account" "main" {
  name                            = lower(replace("${var.resource_name_prefix}-sa", "/[-_]/", ""))
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  tags                            = var.tags
  allow_nested_items_to_be_public = true
}

# Create Storage Account
resource "azurerm_storage_account" "pkpass" {
  name                            = lower(replace("${var.resource_name_prefix}pkpass-sa", "/[-_]/", ""))
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  tags                            = var.tags
  allow_nested_items_to_be_public = true
}

resource "azurerm_storage_container" "pkpass" {
  name                  = "pkpass"
  storage_account_name  = azurerm_storage_account.pkpass.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "images" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.pkpass.name
  container_access_type = "private"
}

# Create Function App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.resource_name_prefix}-asp"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = "Y1"
  tags                = var.tags
}


# Create Function App
resource "azurerm_windows_function_app" "main" {
  name                        = "${var.resource_name_prefix}-fa"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  storage_account_name        = azurerm_storage_account.main.name
  storage_account_access_key  = azurerm_storage_account.main.primary_access_key
  service_plan_id             = azurerm_service_plan.main.id
  functions_extension_version = "~4"

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_key = var.instrumentation_key
    application_stack {
      node_version = "~20"
    }
  }

  tags = var.tags

  app_settings = {
    KEY_VAULT_URL                 = var.keyvault_url
    KEY_VAULT_SECRET_ROOT_CERT    = "wwdrCert"
    KEY_VAULT_SECRET_SIGNING_CERT = "signerCert"
    KEY_VAULT_SECRET_SIGNING_KEY  = "signerKey"
    STORAGE_ACCOUNT_PASS          = azurerm_storage_account.pkpass.name
    COSMOSDB_ACCOUNT              = var.azurerm_cosmosdb_account_name
  }

  lifecycle {
    ignore_changes = [
      app_settings["AzureWebJobsDashboard"],
      app_settings["AzureWebJobsStorage"],
      app_settings["FUNCTIONS_EXTENSION_VERSION"],
      app_settings["FUNCTIONS_WORKER_RUNTIME"],
      app_settings["WEBSITE_CONTENTAZUREFILECONNECTIONSTRING"],
      app_settings["WEBSITE_CONTENTSHARE"],
      app_settings["WEBSITE_ENABLE_SYNC_UPDATE_SITE"],
      app_settings["WEBSITE_NODE_DEFAULT_VERSION"],
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      app_settings["WEBSITE_ENABLE_SYNC_UPDATE_SITE"],
      app_settings["APPINSIGHTS_INSTRUMENTATIONKEY"],
      app_settings["KEY_VAULT_URL"],
      app_settings["STORAGE_ACCOUNT_PASS"],
      app_settings["COSMOSDB_ACCOUNT"],
      app_settings["COSMOSDB_DATABASE"],
      app_settings["B2C_CLIENT_ID"],
      app_settings["B2C_ISSUER"],
      app_settings["B2C_EXTENSIONS_APP_ID"],
      app_settings["B2C_AUTH_USERNAME"],
      app_settings["B2C_AUTH_PASSWORD"]
    ]
  }
}

# resource "azurerm_windows_function_app_slot" "dev" {
#   name                        = "dev"
#   function_app_id             = azurerm_windows_function_app.main.id
#   storage_account_name        = azurerm_storage_account.main.name
#   storage_account_access_key  = azurerm_storage_account.main.primary_access_key
#   functions_extension_version = "~4"

#   identity {
#     type = "SystemAssigned"
#   }

#   site_config {
#     application_insights_key = var.instrumentation_key
#     application_stack {
#       node_version = "~20"
#     }
#   }

#   tags = var.tags

#   app_settings = {
#     KEY_VAULT_URL                 = var.keyvault_url
#     KEY_VAULT_SECRET_ROOT_CERT    = "wwdrCert"
#     KEY_VAULT_SECRET_SIGNING_CERT = "signerCert"
#     KEY_VAULT_SECRET_SIGNING_KEY  = "signerKey"
#     STORAGE_ACCOUNT_PASS          = azurerm_storage_account.pkpass.name
#     COSMOSDB_ACCOUNT              = var.azurerm_cosmosdb_account_name
#   }

#   lifecycle {
#     ignore_changes = [
#       app_settings["AzureWebJobsDashboard"],
#       app_settings["AzureWebJobsStorage"],
#       app_settings["FUNCTIONS_EXTENSION_VERSION"],
#       app_settings["FUNCTIONS_WORKER_RUNTIME"],
#       app_settings["WEBSITE_CONTENTAZUREFILECONNECTIONSTRING"],
#       app_settings["WEBSITE_CONTENTSHARE"],
#       app_settings["WEBSITE_ENABLE_SYNC_UPDATE_SITE"],
#       app_settings["WEBSITE_NODE_DEFAULT_VERSION"],
#       app_settings["WEBSITE_RUN_FROM_PACKAGE"],
#       app_settings["WEBSITE_ENABLE_SYNC_UPDATE_SITE"],
#       app_settings["APPINSIGHTS_INSTRUMENTATIONKEY"],
#       app_settings["KEY_VAULT_URL"],
#       app_settings["STORAGE_ACCOUNT_PASS"],
#       app_settings["COSMOSDB_ACCOUNT"],
#       app_settings["COSMOSDB_DATABASE"],
#       app_settings["B2C_CLIENT_ID"],
#       app_settings["B2C_ISSUER"],
#       app_settings["B2C_EXTENSIONS_APP_ID"],
#       app_settings["B2C_AUTH_USERNAME"],
#       app_settings["B2C_AUTH_PASSWORD"]
#     ]
#   }
# }


resource "azurerm_role_assignment" "secret" {
  scope                = var.keyvault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_windows_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "certificate" {
  scope                = var.keyvault_id
  role_definition_name = "Key Vault Certificate User"
  principal_id         = azurerm_windows_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "storage" {
  scope                = azurerm_storage_account.pkpass.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_windows_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "storage_user" {
  scope                = azurerm_storage_account.pkpass.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.current_user_id
}

resource "random_uuid" "cosmosdb" {}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmosdb" {
  name                = random_uuid.cosmosdb.result
  resource_group_name = var.resource_group_name
  account_name        = var.azurerm_cosmosdb_account_name
  role_definition_id  = "${data.azurerm_subscription.main.id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.DocumentDB/databaseAccounts/${var.azurerm_cosmosdb_account_name}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = azurerm_windows_function_app.main.identity[0].principal_id
  scope               = data.azurerm_cosmosdb_account.main.id
}

resource "random_uuid" "cosmosdb_user" {}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmosdb_user" {
  name                = random_uuid.cosmosdb_user.result
  resource_group_name = var.resource_group_name
  account_name        = var.azurerm_cosmosdb_account_name
  role_definition_id  = "${data.azurerm_subscription.main.id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.DocumentDB/databaseAccounts/${var.azurerm_cosmosdb_account_name}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = var.current_user_id
  scope               = data.azurerm_cosmosdb_account.main.id
}
