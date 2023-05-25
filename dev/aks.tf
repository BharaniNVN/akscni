module "aks" {
  source = "../modules/aks_cni"

  acrname = "demoacrinoct"
  aksname = "demoaksinovt" 
  resource_group_name = module.aks_network.rg_name
  location = "eastus"
  sku = "Premium"
  subnet_id = module.aks_network.subnet
  network_plugin = "azure"
  network_policy = "azure"
  #aks_id = module.aksid.aks_id
  #acr_id = module.acrid.acr_id

} 


# output "acr_id"{
#     value = module.acrid
# }

# output "aks_id"{
#     value = module.aksid
# }
