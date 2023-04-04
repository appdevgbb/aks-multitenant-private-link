module "product-1" {
    source = "./product-1"

    prefix = var.prefix
    location = var.location
    nginx_jwt_path = var.nginx_jwt_path
    auto_approval_subscription_ids              = var.auto_approval_subscription_ids
    visibility_subscription_ids                 = var.visibility_subscription_ids
}