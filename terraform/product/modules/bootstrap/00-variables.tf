variable kube_config {
    type = string
}

variable "nginx_jwt_path" {
  type = string
}

variable "ingress_lb_ip" {
  type = string
}

variable "nginx_plus_image_name" {
  type = string
}

variable "image_repository" {
  type = string
  default = "private-registry.nginx.com/nginx-ic/nginx-plus-ingress"
}

variable "nginx_plus_tag" {
  type = string
}

variable "ingress_lb_subnet_name" {
  type = string
}