output "resource_group" {
  value = azurerm_resource_group.default
}

output "mc_resource_group" {
  value = azurerm_kubernetes_cluster.default.node_resource_group
}

output "public_ip" {
    value = azurerm_public_ip.default.ip_address
}

output "private_link_subnet_id" {
  value = azurerm_subnet.private_link.id
}