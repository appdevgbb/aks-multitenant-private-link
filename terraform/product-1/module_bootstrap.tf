module "bootstrap" {
    source = "./modules/bootstrap"

    # Presumes that aks/k8s local accounts is enabled
    kube_config = azurerm_kubernetes_cluster.default.kube_config_raw
    nginx_jwt_path = var.nginx_jwt_path

    ingress_lb_ip = cidrhost(azurerm_subnet.aks_load_balancer.address_prefixes[0], 4)
    resource_group_name = azurerm_resource_group.default.name
    registry_fqdn = azurerm_container_registry.default.login_server
    nginx_plus_image_name = "nginx-ingress"
    nginx_plus_tag = "3.1.0"
}