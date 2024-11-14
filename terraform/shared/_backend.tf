terraform {
  backend "azurerm" {
    resource_group_name  = "beatpass-tfstate-rg"
    storage_account_name = "beatpasstfstatesa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate:shared"
    tenant_id            = "6781348b-58d8-4ec2-89b8-fde80f099350"
    subscription_id      = "26c42b58-838c-4899-b113-0245b2812864"
  }
}