
# resource "azurerm_resource_group" "WINVMRG" {
#   for_each = var.winvm
#   name     = "${each.key}-rg"
#   location = each.value.location
# }

# resource "azurerm_virtual_network" "winvmvnet" {
#   for_each            = var.winvm
#   name                = "${each.value.name}-vnet"
#   address_space       = each.value.vnetspace
#   location            = data.azurerm_resource_group.rg[each.key].location
#   resource_group_name = data.azurerm_resource_group.rg[each.key].name
# }

# resource "azurerm_subnet" "winvmsnet" {
#   for_each             = var.winvm
#   # depends_on = [azurerm_virtual_network.winvmvnet]
#   name                 = "${each.key}-snet"
#   resource_group_name  = data.azurerm_resource_group.rg[each.key].name
#   virtual_network_name = data.azurerm_virtual_network.vnet1.name
#   address_prefixes     = each.value.snetadd
# }

# resource "azurerm_public_ip" "public_ip" {
#   for_each            = var.winvm
#   name                = "${each.value.name}-pip"
#   resource_group_name = azurerm_resource_group.WINVMRG[each.key].name
#   location            = azurerm_virtual_network.winvmvnet[each.key].location
#   allocation_method   = "Static"
# }

resource "azurerm_network_interface" "winvmnic" {
  for_each            = var.winvm
  name                = "${each.value.name}-nic"
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snetdata[each.key].id
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.pvtip
    # public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id

  }
}

resource "azurerm_windows_virtual_machine" "winvm" {
  for_each            = var.winvm
  name                = "${each.value.name}wvm"
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  location            = data.azurerm_resource_group.rg[each.key].location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.kvu.value
  admin_password      = data.azurerm_key_vault_secret.kvp.value
  network_interface_ids = [
    azurerm_network_interface.winvmnic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}