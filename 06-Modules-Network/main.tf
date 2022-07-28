resource "azurerm_resource_group" "Linorg" {
  name     = "Linorg"
  location = "East US"
}

resource "random_name" "Linorg" {
  name = "Linorg"
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.Linorg.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["linopublicdnseastus"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  vm_size             = "Standard_B1ls"
  depends_on          = [azurerm_resource_group.Linorg]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.Linorg.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.Linorg]
}

output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_dns_name
}
output "linux_vm_public_ip" {
  value = module.linuxservers.public_ip_address
}