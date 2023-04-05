module "product" {
    source = "./product"

    prefix = var.prefix
    location = var.location
    nginx_jwt_path = var.nginx_jwt_path
    admin_username = var.admin_username
    ssh_public_key_path = var.ssh_public_key_path
    myip = local.myip
}

data "azurerm_lb" "ingress-internal"{
    resource_group_name = module.product.mc_resource_group
    name = "kubernetes-internal"
}

resource "azurerm_private_link_service" "example" {
    name                = "product1-pls"
    resource_group_name = module.product.resource_group.name
    location            = module.product.resource_group.location

    auto_approval_subscription_ids              = var.auto_approval_subscription_ids
    visibility_subscription_ids                 = var.visibility_subscription_ids
    load_balancer_frontend_ip_configuration_ids = [data.azurerm_lb.ingress-internal.frontend_ip_configuration.0.id]

    enable_proxy_protocol = true

    nat_ip_configuration {
        name                       = "primary"
        private_ip_address_version = "IPv4"
        subnet_id                  = module.product.private_link_subnet_id
        primary                    = true
    }
}