resource "azurerm_container_registry" "default" {
  name                = "${var.prefix}acr"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Premium"
}

resource "azurerm_role_assignment" "kubelet" {
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.default.id
  skip_service_principal_aad_check = true
  principal_id                     = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
}


resource "azurerm_role_assignment" "current_user" {
  role_definition_name             = "Contributor"
  scope                            = azurerm_container_registry.default.id
  skip_service_principal_aad_check = true
  principal_id                     = data.azurerm_client_config.current.client_id
}