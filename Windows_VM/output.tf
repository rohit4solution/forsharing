output "azurerm_public_ip" {
#      for_each = var.winvm
#   value = data.azurerm_public_ip.public_ip[each.key].ip_address
  value = [for vm in azurerm_windows_virtual_machine.winvm : vm.public_ip_address]
}