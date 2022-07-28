resource "azurerm_resource_group" "LinoRg" {
  name     = "LinoResourceGroup"
  location = var.location
}

resource "azurerm_virtual_network" "linovnet" {
  name                = "lino-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.LinoRg.location
  resource_group_name = azurerm_resource_group.LinoRg.name
}

resource "azurerm_subnet" "linosubnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.LinoRg.name
  virtual_network_name = azurerm_virtual_network.linovnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "linonic" {
  name                = "example-nic"
  location            = azurerm_resource_group.LinoRg.location
  resource_group_name = azurerm_resource_group.LinoRg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linosubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linolinuxvm" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.LinoRg.name
  location            = azurerm_resource_group.LinoRg.location
  size                = "Standard_F2"
  admin_username      = "linoadmin"
  network_interface_ids = [
    azurerm_network_interface.linonic.id,
  ]

  admin_ssh_key {
    username   = "linoadmin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  tags = {
    Name = local.project_name
  }
}

