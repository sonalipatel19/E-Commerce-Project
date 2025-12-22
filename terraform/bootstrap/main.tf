provider "azurerm" {
  features {}
  subscription_id = "1385ca62-7cc4-4229-b0dc-3eec83590cd8"
}

module "resource_group" {
  source   = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/rg?ref=master"
  name     = var.resource_group_name
  location = var.rg_location

}

module "storage_account" {
  source                   = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/storage?ref=master"
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.rg_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  depends_on = [module.resource_group]
}

module "container" {
  source                   = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/container?ref=master"
  container_name           = var.container_name
  storage_account_id       = module.storage_account.storageaccount_id
  access_type              = var.access_type

  depends_on = [module.storage_account]
}
