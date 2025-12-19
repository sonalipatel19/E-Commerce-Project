variable "resource_group_name" {
    type    = string
}

variable "rg_location" {
    type    = string        
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
variable "storage_account_name" { type = string }
variable "account_tier" { type = string }
variable "account_replication_type" { type = string }

variable "acr_name" { type = string }
variable "acr_sku" {
  type    = string
  default = "Standard"
}
variable "acr_admin_enabled" {
  type    = bool
  default = false
}
variable "container_name" {
  type    = string
  
}
variable "access_type" {
  type    = string
  default = "private"
}
