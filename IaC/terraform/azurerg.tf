provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "k8POC" {
  name     = "k8Playground"
  location = "West US"
}