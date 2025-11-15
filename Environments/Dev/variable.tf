variable "rgs" {
  type = map(object({
    name = string
    location = string
    managed_by = optional(string)
    tags = optional(map(string))
  }))
}


variable "stg" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    tags                     = optional(map(string))
  }))
}

variable "vnet" {
  
}

variable "pip" {
  
}

variable "vms" {
  
}

variable "kv" {
  
}

variable "kvsecrets" {
  
}

variable "nsg" {
  
}
variable "sqlservers" {
  
}