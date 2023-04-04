data "azurerm_lb" "ingress-internal"{
    resource_group_name = azurerm_kubernetes_cluster.default.node_resource_group
    name = "kubernetes-internal"
}

resource "azurerm_private_link_service" "example" {
    name                = "product-1-pls"
    resource_group_name = azurerm_resource_group.default.name
    location            = azurerm_resource_group.default.location

    auto_approval_subscription_ids              = local.auto_approval_subscription_ids
    visibility_subscription_ids                 = local.visibility_subscription_ids
    load_balancer_frontend_ip_configuration_ids = [data.azurerm_lb.ingress-internal.frontend_ip_configuration[0].id]

    enable_proxy_protocol = true

    nat_ip_configuration {
        name                       = "primary"
        private_ip_address_version = "IPv4"
        subnet_id                  = azurerm_subnet.private_link.id
        primary                    = true
    }
}