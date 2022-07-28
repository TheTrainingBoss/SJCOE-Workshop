data "azurerm_client_config" "config" {
  
}

output "ObjectId" {
  value = data.azurerm_client_config.config.object_id
}

output "TenantId" {
  value = data.azurerm_client_config.config.tenant_id
} 

output "ClientID" {
  value = data.azurerm_client_config.config.client_id
} 

output "SubscriptionId" {
  value = data.azurerm_client_config.config.subscription_id
} 