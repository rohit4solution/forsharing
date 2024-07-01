vnets = {
  vnet1 = {
    vnetName      = "G13Vnet1"
    location      = "westeurope"
    rg_name       = "G13rg"
    address_space = ["10.0.0.0/16"]
    g13subnet = {
      snet1 = {
        name           = "subnet1"
        address_prefix = "10.0.1.0/24"
      }
      snet2 = {
        name           = "subnet2"
        address_prefix = "10.0.2.0/24"
      }
      snet3 = {
        name           = "subnet3"
        address_prefix = "10.0.3.0/24"
      }
    }
  }
  vnet2 = {
    vnetName      = "G13Vnet2"
    location      = "Central India"
    rg_name       = "G13rgii"
     address_space = ["10.1.0.0/16"]
    g13subnet = {
      snet1 = {
        name           = "subnet1"
        address_prefix = "10.1.1.0/24"
      }
      snet2 = {
        name           = "subnet2"
        address_prefix = "10.1.2.0/24"
      }
    }
  }

#   vnet3 = {
#     vnetName      = "G13Vnet1"
#     location      = "westeurope"
#     rg_name       = "G13rg"
#     address_space = ["10.1.0.0/16"]
# }
}