output ssh {
    value = { for idx, vm in module.customers: "vm${idx + 1}" => "${vm.admin_username}@${vm.public_ip}" }
}

output private_endpoint {
    value = {
        for idx, pls in module.customers: "pls${idx + 1}" => pls.private_endpoint_ip
    }
}