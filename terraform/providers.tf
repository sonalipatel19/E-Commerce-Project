terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "1385ca62-7cc4-4229-b0dc-3eec83590cd8"
}


