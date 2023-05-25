resource "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.aksname
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aksname

  default_node_pool {
    name                = "default"
    node_count          = 2
    vm_size             = "standard_e4bds_v5"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
    min_count             = null
    max_count             = null
    max_pods              = 50
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = "standard"
    network_policy    = var.network_policy
  }

  tags = {
    Environment = "dev"
  }

  depends_on  = [azurerm_container_registry.acr]
}

# resource "azurerm_role_assignment" "acr-aks" {
#     principal_id                     = var.aks_id
#     role_definition_name             = "AcrPull"
#     scope                            = var.acr_id
#     skip_service_principal_aad_check = true
#     depends_on                       = [azurerm_container_registry.acr, azurerm_kubernetes_cluster.cluster]
#   }

resource "local_file" "kubeconfig" {
  filename       = "kubeconfig"
  depends_on = [azurerm_kubernetes_cluster.cluster]
  content    = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}

output "acrid"{
    value = azurerm_container_registry.acr.id
}

output "aksid"{
    value = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}