output "linolinuxvm_privateIP" {
  value = azurerm_linux_virtual_machine.linolinuxvm.private_ip_address
}
output "linolinuxvm_publicIP" {
  value = azurerm_linux_virtual_machine.linolinuxvm.public_ip_address
}