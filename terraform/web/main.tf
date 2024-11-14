locals {
  resource_name_prefix_web = "${module.global_vars.resource_name_prefix}-web"
  resource_name_prefix_shared = "${module.global_vars.resource_name_prefix}-shared"
}

data "azurerm_application_insights" "main" {
  name                 = "${local.resource_name_prefix_shared}-ai"
  resource_group_name  = "${local.resource_name_prefix_shared}-rg"
}

module "resource_group_web" {
  source               = "../modules/resource-group"
  resource_name_prefix = local.resource_name_prefix_web
  location             = module.global_vars.location
  tags                 = module.global_vars.tags
}
