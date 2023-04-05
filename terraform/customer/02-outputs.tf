output "resource_group" {
  value = azurerm_resource_group.default
}
output "admin_username" {
    value = local.admin_username
}

output "public_ip" {
    value = azurerm_public_ip.default.ip_address
}

output "customer_name" {
    value = local.customer_name
}

output "vnet_id" {
    value = azurerm_virtual_network.default.id
}

output "private_endpoint_subnet_id" {
    value = azurerm_subnet.private_endpoint.id
}

output "index" {
    value = var.index
}