variable "resource_group_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "virtual_network_name" {
    type    = string
}

variable "address_space" {
    type    = string
}

variable "subnet_name" {
    type    = string
}

variable "address_prefixes" {
    type    = string
}
variable "network_security_group_name" {
    type    = string
}

variable "network_security_rule_name" {
    type    = string
}

variable "priority" {
    type    = string
}

variable "direction" {
    type    = string
}

variable "access" {
    type    = string
}

variable "protocol" {
    type    = string
}

variable "source_port_range" {
    type    = string
}

variable "destination_port_range" {
    type    = string
}

variable "source_address_prefix" {
    type    = string
}

variable "destination_address_prefix" {
    type    = string
}

variable "acr_name" { type = string }
variable "acr_sku" {
  type    = string
  default = "Standard"
}
variable "acr_admin_enabled" {
  type    = bool
  default = false
}

variable "aks_name" {}
variable "dns_prefix" {}
variable "kubernetes_version" {
  default = "1.29.6"  # example version
}
variable "node_count" {
  default = 1
}
variable "vm_size" {
  default = "Standard_B2s"
}
