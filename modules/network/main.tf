resource "azurerm_resource_group" "aks_rg" {

  location = var.location
  name     = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
   resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_space]
}

output "rg_name"{
  value = azurerm_resource_group.aks_rg.name
}

output "vnet"{
  value = azurerm_virtual_network.vnet.id
}

output "subnet"{
  value = azurerm_subnet.subnet.id
}
