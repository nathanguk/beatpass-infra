locals {
  resource_name_prefix_api    = "${module.global_vars.resource_name_prefix}-api"
  resource_name_prefix_shared = "${module.global_vars.resource_name_prefix}-shared"
}

data "azurerm_application_insights" "main" {
  name                = "${local.resource_name_prefix_shared}-ai"
  resource_group_name = "${local.resource_name_prefix_shared}-rg"
}

module "keyvault" {
  source               = "../modules/keyvault"
  resource_name_prefix = local.resource_name_prefix_api
  resource_group_name  = module.resource_group_api.name
  location             = module.global_vars.location
  tags                 = module.global_vars.tags
  tenant_id            = module.global_vars.tenant_id
  current_user_id      = module.global_vars.current_user_id
}

module "resource_group_api" {
  source               = "../modules/resource-group"
  resource_name_prefix = local.resource_name_prefix_api
  location             = module.global_vars.location
  tags                 = module.global_vars.tags
}

module "function_app_api" {
  source                        = "../modules/function-app"
  resource_name_prefix          = local.resource_name_prefix_api
  resource_group_name           = module.resource_group_api.name
  location                      = module.global_vars.location
  tags                          = module.global_vars.tags
  instrumentation_key           = data.azurerm_application_insights.main.instrumentation_key
  keyvault_url                  = module.keyvault.keyvault_url
  keyvault_id                   = module.keyvault.keyvault_id
  tenant_id                     = module.global_vars.tenant_id
  current_user_id               = module.global_vars.current_user_id
  azurerm_cosmosdb_account_name = module.cosmosdb.cosmosdb_account_name
}

module "cosmosdb" {
  source               = "../modules/cosmos-db"
  resource_name_prefix = local.resource_name_prefix_api
  resource_group_name  = module.resource_group_api.name
  location             = module.global_vars.location
  tags                 = module.global_vars.tags
  throughput           = 1000
}
