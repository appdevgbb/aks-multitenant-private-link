resource "azurerm_kubernetes_cluster" "default" {
  name                    = local.cluster_name
  location                = azurerm_resource_group.default.location
  resource_group_name     = azurerm_resource_group.default.name

  dns_prefix = local.cluster_name

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
    service_cidr = "172.18.0.0/22"
    dns_service_ip = "172.18.0.5"
  }

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name = "defaultnp01"
    vm_size = "Standard_D4s_v3"
    vnet_subnet_id = azurerm_subnet.aks.id
    node_count = 1
  }
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_virtual_network.default.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.default.identity[0].principal_id
}