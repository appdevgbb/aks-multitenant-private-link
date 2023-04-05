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

    private_link_service_network_policies_enabled = false

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

    private_link_service_network_policies_enabled = false
    
    address_prefixes = [
        "10.0.3.0/24"
    ]
}

resource "azurerm_subnet" "jumpbox" {
    name = "JumpboxSubnet"
    resource_group_name = azurerm_resource_group.default.name
    virtual_network_name = azurerm_virtual_network.default.name
    
    address_prefixes = [
        "10.0.4.0/24"
    ]
}


resource "azurerm_network_security_group" "default" {
  
	name                = "default-nsg"
  	location            = azurerm_resource_group.default.location
  	resource_group_name = azurerm_resource_group.default.name

  	security_rule {
		name                       = "AllowSSHInbound22"
		priority                   = 100
		direction                  = "Inbound"
		access                     = "Allow"
		protocol                   = "Tcp"
		source_port_range          = "*"
		destination_port_range     = "22"
		source_address_prefix      = "${local.myip}"
		destination_address_prefix = "*"
	}

	security_rule {
		name                       = "AllowHttpInternetInbound"
		priority                   = 200
		direction                  = "Inbound"
		access                     = "Allow"
		protocol                   = "Tcp"
		source_port_range          = "*"
		destination_port_range     = "80"
		source_address_prefix      = "*"
		destination_address_prefix = "*"
	}

	security_rule {
		name                       = "AllowHttpsInternetInbound"
		priority                   = 201
		direction                  = "Inbound"
		access                     = "Allow"
		protocol                   = "Tcp"
		source_port_range          = "*"
		destination_port_range     = "443"
		source_address_prefix      = "*"
		destination_address_prefix = "*"
	}
}

resource "azurerm_subnet_network_security_group_association" "default" {
	subnet_id                                = azurerm_subnet.jumpbox.id
	network_security_group_id 			     = azurerm_network_security_group.default.id
}