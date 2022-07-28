resource "azurerm_resource_group" "linorg" {
  name     = "linorg"
  location = "East US"
}

resource "azurerm_service_plan" "linolinuxserviceplan" {
  name                = "linolinuxserviceplan"
  resource_group_name = azurerm_resource_group.linorg.name
  location            = azurerm_resource_group.linorg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

/* resource "azurerm_windows_web_app" "linoappservice" {
  name                = "linoappservice"
  resource_group_name = azurerm_resource_group.linorg.name
  location            = azurerm_service_plan.linolinuxserviceplan.location
  service_plan_id     = azurerm_service_plan.linolinuxserviceplan.id

  site_config {}
} */

resource "azurerm_linux_web_app" "linolinuxappservice" {
  name                = "linolinuxappservice"
  resource_group_name = azurerm_resource_group.linorg.name
  location            = azurerm_service_plan.linolinuxserviceplan.location
  service_plan_id     = azurerm_service_plan.linolinuxserviceplan.id

  site_config {
    application_stack {
      dotnet_version = "6.0" //try "7.0" and see what happens, also try "5.0"
    }
  }
}