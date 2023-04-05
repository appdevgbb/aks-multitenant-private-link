output ssh {
    value = { for idx, vm in module.customers: "vm${idx + 1}" => "${vm.admin_username}@${vm.public_ip}" }
}

output product_jumpbox {
    value = "ssh ${var.admin_username}@${module.product.public_ip}"
}