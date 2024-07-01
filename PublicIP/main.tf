resource "azurerm_public_ip" "example" {
  name                = "${data.azurerm_resource_group.rgname.name}-pip"
  resource_group_name = data.azurerm_resource_group.rgname.name
  location            = data.azurerm_resource_group.rgname.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
}