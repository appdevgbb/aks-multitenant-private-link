module "customers" {
  source = "./customer"

  count = 1
  
  prefix = var.prefix
  
  index = "${count.index + 1}"
  customer_name = "customer${count.index + 1}"

  location = var.location
  admin_username = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  myip = local.myip
}

resource "azurerm_private_endpoint" "example" {
  count = length(module.customers)
  
  name                = "${module.customers[count.index].customer_name}-to-product-1-endpoint"
  location            = module.customers[count.index].resource_group.location
  resource_group_name = module.customers[count.index].resource_group.name
  subnet_id           = module.customers[count.index].private_endpoint_subnet_id

  private_service_connection {
    name                           = "${module.customers[count.index].customer_name}-product-1-pls"
    private_connection_resource_id = azurerm_private_link_service.example.id
    is_manual_connection           = false
  }
}


resource "azurerm_private_dns_zone" "default" {
  count = length(module.customers)
  
  name                = var.private_dns_zone_name
  resource_group_name = module.customers[count.index].resource_group.name
}

resource "azurerm_private_dns_a_record" "customer" {
    count = length(module.customers)

    name                = module.customers[count.index].customer_name
    zone_name           = azurerm_private_dns_zone.default[count.index].name
    resource_group_name = module.customers[count.index].resource_group.name
    ttl                 = 10
    records             = [azurerm_private_endpoint.example[count.index].private_service_connection[0].private_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "default" {
    count = length(module.customers)
    
    name              = "${module.customers[count.index].customer_name}-to-product-link"
    resource_group_name = module.customers[count.index].resource_group.name
    private_dns_zone_name = azurerm_private_dns_zone.default[count.index].name
    virtual_network_id = module.customers[count.index].vnet_id
}