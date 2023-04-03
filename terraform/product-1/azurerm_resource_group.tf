resource azurerm_resource_group default {
    name = "${local.prefix}-product-1"
    location = local.location
}