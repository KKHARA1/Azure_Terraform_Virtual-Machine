data "azurerm_key_vault" "kvsdata" {
    for_each = var.kvsecrets
  name                = each.value.kvname
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_key_vault_secret" "kvsecret" {
    for_each = var.kvsecrets
  name         = each.value.kvsecretsname
  value        = each.value.kvsecretvalue
  key_vault_id = data.azurerm_key_vault.kvsdata[each.key].id
}