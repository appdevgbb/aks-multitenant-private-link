module "customers" {
  source = "./customer"

  count = 2

  prefix = var.prefix
  index = "${count.index + 1}"
  customer_name = "customer${count.index + 1}"
  location = var.location
  pls_id = module.product-1.pls_id
  admin_username = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  myip = local.myip
  private_dns_zone_name = var.private_dns_zone_name
}