variable "resource_group_name" {
    type    = string
}

variable "rg_location" {
    type    = string        
}

variable "storage_account_name" { type = string }
variable "account_tier" { type = string }
variable "account_replication_type" { type = string }

variable "container_name" {
  type    = string
  
}
variable "access_type" {
  type    = string
  default = "private"
}