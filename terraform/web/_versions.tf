#Provider Versions

terraform {
  required_version = "~> 1.9.5"  
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
