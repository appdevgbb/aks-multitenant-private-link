
resource "azurerm_private_dns_zone" "default" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_private_dns_a_record" "customer" {
  name                = local.customer_name
  zone_name           = azurerm_private_dns_zone.default.name
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 10
  records             = [azurerm_private_endpoint.example.private_service_connection[0].private_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name              = "${local.customer_name}-to-product-link"
  resource_group_name = azurerm_resource_group.default.name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id = azurerm_virtual_network.default.id
}