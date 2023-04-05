module "product" {
    source = "./product"

    prefix = var.prefix
    location = var.location
    nginx_jwt_path = var.nginx_jwt_path
    auto_approval_subscription_ids              = var.auto_approval_subscription_ids
    visibility_subscription_ids                 = var.visibility_subscription_ids
    admin_username = var.admin_username
    ssh_public_key_path = var.ssh_public_key_path
    myip = local.myip
}