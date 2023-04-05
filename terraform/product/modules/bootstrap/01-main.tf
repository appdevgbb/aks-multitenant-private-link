# provider "kubernetes" {
#   config_path    = local_file.kube_config_server_yaml.filename
# }

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_config_server_yaml.filename
  }
}

resource "local_file" "kube_config_server_yaml" {
  filename = format("%s/%s", path.root, "kube_config.yaml")
  content  = var.kube_config
  file_permission = "0600"
}

locals {
  nginx_jwt = file(var.nginx_jwt_path)
}