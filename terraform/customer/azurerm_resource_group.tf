resource azurerm_resource_group default {
    name = "${var.prefix}-${local.customer_name}"
    location = var.location
}