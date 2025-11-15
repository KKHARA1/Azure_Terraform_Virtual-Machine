data "azurerm_network_interface" "nicdata" {
    for_each = var.nsg
  name                = each.value.nicname
  resource_group_name = each.value.resource_group_name
}
