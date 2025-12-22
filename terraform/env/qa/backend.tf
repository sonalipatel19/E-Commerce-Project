terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "storage12b" # must be globally unique
    container_name       = "terraform"
    key                  = "qa.terraform.tfstate"
  }
}
