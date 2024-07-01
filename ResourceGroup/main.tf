
resource "azurerm_resource_group" "WINVMRG" {
  for_each = var.winvmrg
  name     = "${each.key}-rg"
  location = each.value.location
}