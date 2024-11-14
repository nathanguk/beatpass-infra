#Provider Versions

terraform {
  required_version = "~> 1.9.5"  
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.53.1"
    }
  }
}
