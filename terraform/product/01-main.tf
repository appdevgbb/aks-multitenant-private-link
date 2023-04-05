
data "azurerm_client_config" "current" { }

locals {
    prefix = var.prefix
    location = var.location
    cluster_name = "azplstestcluster" 
    auto_approval_subscription_ids = var.auto_approval_subscription_ids
    visibility_subscription_ids = var.visibility_subscription_ids
    vm_name = "${var.prefix}-product1-jumpbox"
    admin_username = var.admin_username
    ssh_key = file(var.ssh_public_key_path)
    myip = var.myip
}