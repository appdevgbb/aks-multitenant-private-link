# resource "azurerm_lb" "example" {
#   name                = "product-1-lb"
#   sku                 = "Standard"
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name

#   frontend_ip_configuration {
#     name                 = "primary"
#     subnet_id = azurerm_subnet.private_link_load_balancer.id
#     privateprivate_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_private_link_service" "example" {
#   name                = "product-1-privatelink"
#   resource_group_name = azurerm_resource_group.default.name
#   location            = azurerm_resource_group.default.location

# #   auto_approval_subscription_ids              = ["00000000-0000-0000-0000-000000000000"]
#   load_balancer_frontend_ip_configuration_ids = [azurerm_lb.example.frontend_ip_configuration.0.id]

#   nat_ip_configuration {
#     name                       = "primary"
#     private_ip_address_version = "IPv4"
#     subnet_id                  = azurerm_subnet.private_link.id
#     primary                    = true
#   }
# }