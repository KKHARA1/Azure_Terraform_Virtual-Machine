resource "azurerm_mssql_server" "sqlserver" {
    for_each = var.sqlservers
  name                         = each.value.sqlservername
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
}

resource "azurerm_mssql_database" "sqldb" {
    for_each = var.sqlservers
  name         = each.value.sqldbname
  server_id    = azurerm_mssql_server.sqlserver[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

}