terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.15.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "linorg" {
  name     = "linorg"
  location = "East US"
}