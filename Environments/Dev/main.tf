module "rgca" {
  source = "../../Modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "stgc" {
  depends_on = [ module.rgca ]
  source = "../../Modules/azurerm_storage_accout"
  stg = var.stg
}

module "vnetd" {
  depends_on = [ module.rgca ]
  source = "../../Modules/azurerm_vnet"
  vnet = var.vnet
}

module "pip" {
  depends_on = [ module.rgca ]
  source = "../../Modules/azurerm_public_ip"
  pip = var.pip
}

module "nic" {
  depends_on = [ module.pip , module.rgca , module.kvserc , module.kvs ]
source = "../../Modules/azurerm_compute"
vms = var.vms

}

module "kvs" {
  depends_on = [ module.rgca ]
  source = "../../Modules/azurerm_keyvault"
kv = var.kv
}

module "kvserc" {
  depends_on = [ module.rgca , module.kvs ]
  source = "../../Modules/azurerm_keysecret"
  kvsecrets = var.kvsecrets
}

module "nsgnic" {
  depends_on = [ module.rgca , module.nic , module.vnetd ]
  source = "../../Modules/azurerm_nsg"
  nsg = var.nsg
}

module "sql" {
  depends_on = [ module.rgca ]
source = "../../Modules/azurerm_sqlserver"
sqlservers = var.sqlservers

}