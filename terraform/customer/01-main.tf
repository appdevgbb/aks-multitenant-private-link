locals {
  customer_name = "${var.customer_name}"
  vm_name = "${local.customer_name}clientvm"
  admin_username = var.admin_username
  ssh_key = file(var.ssh_public_key_path)
  myip = var.myip
}