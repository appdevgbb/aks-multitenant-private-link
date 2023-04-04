module "product-1" {
    source = "./product-1"

    prefix = var.prefix
    location = var.location
    nginx_jwt_path = var.nginx_jwt_path
}