/*terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name   = "demo-rg1"       # Resource group containing storage account
    storage_account_name  = "storage12b"   # Storage account name
    container_name        = "terraform"          # Blob container name
    key                   = "terraform.tfstate" # State file name
  }
}*/