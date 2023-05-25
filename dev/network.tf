module "aks_network" {
  source = "../modules/network"

  resource_group_name  = "demorg-aks"
  location             = "eastus"
  vnet_name            = "aks-vnet"
  vnet_address_space   = "192.168.0.0/16"
  subnet_name          = "aks-subnet"
  subnet_address_space = "192.168.1.0/24"
}

output "rg_name"{
    value = module.aks_network.rg_name
}

output "vnet"{
    value = module.aks_network.vnet
}

output "subnet"{
    value = module.aks_network.subnet
}