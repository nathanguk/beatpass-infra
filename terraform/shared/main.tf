locals {
  resource_name_prefix_shared = "${module.global_vars.resource_name_prefix}-shared"
}

module "resource_group_shared" {
  source               = "../modules/resource-group"
  resource_name_prefix = local.resource_name_prefix_shared
  location             = module.global_vars.location
  tags                 = module.global_vars.tags
}

module "app_insights_shared" {
  source               = "../modules/app-insights"
  resource_name_prefix = local.resource_name_prefix_shared
  resource_group_name  = module.resource_group_shared.name
  location             = module.global_vars.location
  tags                 = module.global_vars.tags
}


