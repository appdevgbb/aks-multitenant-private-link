variable kube_config {
    type = string
}

variable "nginx_jwt_path" {
  type = string
}

variable "ingress_lb_ip" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "registry_fqdn" {
  type = string
}

variable "nginx_plus_image_name" {
  type = string
}

variable "nginx_plus_tag" {
  type = string
}

# variable "resource_group_name" {
#     type = string
# }

# variable "ingress_load_balancer_subnet_name" {
#     type = string
# }

# variable "ingress_load_balancer_ip_address" {
#     type = string
# }