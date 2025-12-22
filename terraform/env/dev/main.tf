provider "azurerm" {
  features {}
  subscription_id = "1385ca62-7cc4-4229-b0dc-3eec83590cd8"
}

module "resource_group" {
  source   = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/rg?ref=master"
  name     = var.resource_group_name
  location = var.rg_location

}

module "virtual_network" {
  source              = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/vnet?ref=master"
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.rg_location
  address_space       = var.address_space

  depends_on = [module.resource_group]
}