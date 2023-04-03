resource "azurerm_virtual_network" "default" {
    name = "${local.prefix}-vnet"
    resource_group_name = azurerm_resource_group.default.name
    location = azurerm_resource_group.default.location
    address_space = [
        "10.0.0.0/16"
    ]
}

resource "azurerm_subnet" "private_link_load_balancer" {
    name = "PrivateLinkLoadBalancerSubnet"
    resource_group_name = azurerm_resource_group.default.name
    virtual_network_name = azurerm_virtual_network.default.name

    address_prefixes = [
        "10.0.0.0/24"
    ]
}

resource "azurerm_subnet" "private_link" {
    name = "PrivateLinkSubnet"
    resource_group_name = azurerm_resource_group.default.name
    virtual_network_name = azurerm_virtual_network.default.name

    private_link_service_network_policies_enabled = true

    address_prefixes = [
        "10.0.1.0/24"
    ]
}

resource "azurerm_subnet" "aks_load_balancer" {
    name = "AksLoadBalancerSubnet"
    resource_group_name = azurerm_resource_group.default.name
    virtual_network_name = azurerm_virtual_network.default.name
    address_prefixes = [
        "10.0.2.0/24"
    ]
}

resource "azurerm_subnet" "aks" {
    name = "AksSubnet"
    resource_group_name = azurerm_resource_group.default.name
    virtual_network_name = azurerm_virtual_network.default.name
    
    address_prefixes = [
        "10.0.3.0/24"
    ]
}