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

module "subnet" {
  source               = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/subnet?ref=master"
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.address_prefixes

  depends_on = [module.virtual_network]
}

module "network_security_group" {
  source              = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/nsg?ref=master"
  name                = var.network_security_group_name
  location            = var.rg_location
  resource_group_name = var.resource_group_name

  depends_on = [module.subnet]
}

module "network_security_rule" {
  source                      = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/security-rule?ref=master"
  name                        = var.network_security_rule_name
  priority                    = var.priority
  direction                   = var.direction
  access                      = var.access
  protocol                    = var.protocol
  source_port_range           = var.source_port_range
  destination_port_range      = var.destination_port_range
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name

  depends_on = [module.network_security_group]
}

module "subnet_network_security_group_association" {
  source                    = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/nsg-association?ref=master"
  subnet_id                 = module.subnet.subnet_id
  network_security_group_id = module.network_security_group.network_security_group_id

  depends_on = [module.network_security_group]
}

module "acr" {
  source              = "git::https://github.com/sonalipatel19/Terraform-Module.git//modules/acr?ref=master"
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.rg_location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled

  depends_on          = [module.resource_group]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.rg_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = module.subnet.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }

  depends_on = [module.subnet]
}
