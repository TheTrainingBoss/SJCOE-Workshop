resource "azurerm_resource_group" "LinoSynapserg" {
  name     = "LinoSynapseRD"
  location = "East US"
}
resource "azurerm_storage_account" "example" {
  name                     = "linostorageaccount"
  resource_group_name      = azurerm_resource_group.LinoSynapserg.name
  location                 = azurerm_resource_group.LinoSynapserg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}
resource "azurerm_storage_data_lake_gen2_filesystem" "example" {
  name               = "linoadlsv2"
  storage_account_id = azurerm_storage_account.example.id
}
resource "azurerm_synapse_workspace" "example" {
  name                                 = "linosynapseworspace"
  resource_group_name                  = azurerm_resource_group.LinoSynapserg.name
  location                             = azurerm_resource_group.LinoSynapserg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.example.id
  sql_administrator_login              = "linoadmin"
  sql_administrator_login_password     = "admin1234!"
  aad_admin {
    login     = "AzureAD Admin"
    object_id = "f27bbdc5-8983-49e9-aa77-a79e379c58c3"
    tenant_id = "8bb28354-8a86-4b90-ad8d-933046410b5c"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Env = "production"
  }
}
resource "azurerm_role_assignment" "synapsetoadls" {
  scope                = azurerm_resource_group.LinoSynapserg.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_synapse_workspace.example.identity[0].principal_id
  depends_on = [
    azurerm_synapse_workspace.example
  ]
}