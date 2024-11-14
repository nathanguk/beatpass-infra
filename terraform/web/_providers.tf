# Providers

provider "azurerm" {
  features {}

  subscription_id     = module.global_vars.subscription_id
  tenant_id           = module.global_vars.tenant_id
  storage_use_azuread = true

}



