resource "azurerm_storage_account" "main" {
  name                     = "stdata${random_string.main.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
}

resource "azurerm_storage_container" "minecraft" {
  name                  = "minecraft"
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "vm1_blob_data_owner" {

  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_user_assigned_identity.vm1.principal_id

}

resource "azurerm_role_assignment" "vm2_blob_data_owner" {

  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_user_assigned_identity.vm2.principal_id

}
