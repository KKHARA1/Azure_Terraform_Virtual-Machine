data "azurerm_subnet" "subnetdata" {
  for_each = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pipdata" {
  for_each = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "kv" {
  for_each = var.vms
  name                = each.value.kvname
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "kvuser" {
  for_each = var.vms
  name         = each.value.kvusername
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "kvpass" {
  for_each = var.vms
  name         = each.value.kvuserpass
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
