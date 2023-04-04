resource "azurerm_private_endpoint" "example" {
  name                = "${local.customer_name}-to-product-1-endpoint"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  subnet_id           = azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "customer-1-product-1-pls"
    private_connection_resource_id = var.pls_id
    is_manual_connection           = false
  }
}