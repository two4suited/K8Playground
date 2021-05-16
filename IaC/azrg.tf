provider "azurerm" {
  features{}
}


resource "azurerm_resource_group" "k8POC" {
    name = "k8POC"
    location = "West US"  
}