output "admin_username" {
    value = local.admin_username
}

output "public_ip" {
    value = azurerm_public_ip.default.ip_address
}

output "private_endpoint_ip" {
    value = azurerm_private_endpoint.example.private_service_connection[0].private_ip_address
}