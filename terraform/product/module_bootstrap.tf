module "bootstrap" {
    source = "./modules/bootstrap"

    # Presumes that aks/k8s local accounts is enabled
    kube_config = azurerm_kubernetes_cluster.default.kube_config_raw
    
    image_repository = "private-registry.nginx.com/nginx-ic/nginx-plus-ingress"
    nginx_jwt_path = var.nginx_jwt_path
    nginx_plus_image_name = "nginx-ingress"
    nginx_plus_tag = "3.1.0"
    
    ingress_lb_ip = cidrhost(azurerm_subnet.aks_load_balancer.address_prefixes[0], 4)
    ingress_lb_subnet_name = azurerm_subnet.aks_load_balancer.name
}