data "azurerm_virtual_network" "librechat_network" {
  name                = "vnet01"
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "librechat_subnet" {
  name                 = "subnet-1"
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.librechat_network.name
  
}
