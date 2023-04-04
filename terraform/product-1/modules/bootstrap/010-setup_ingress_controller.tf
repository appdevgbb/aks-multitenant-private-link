resource "null_resource" "create_nginx_ingress_namespace" {

  triggers = {
    kubec_config_hash = "${sha256(base64encode(file(local_file.kube_config_server_yaml.filename)))}"
  }

  provisioner "local-exec" {
    command     = "export KUBECONFIG=${local_file.kube_config_server_yaml.filename}; kubectl create ns nginx-ingress"
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "create_nginx_docker_secret" {
    depends_on = [
      null_resource.create_nginx_ingress_namespace
    ]

  triggers = {
    kubec_config_hash = "${sha256(base64encode(file(local_file.kube_config_server_yaml.filename)))}"
    jwt_hash = "${sha256(local.nginx_jwt)}"
  }

  provisioner "local-exec" {
    command     = "export KUBECONFIG=${local_file.kube_config_server_yaml.filename}; kubectl create secret docker-registry regcred --docker-server=private-registry.nginx.com --docker-username=${local.nginx_jwt} --docker-password=none -n nginx-ingress"
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "helm_release" "nginx_plus" {
  depends_on = [
    null_resource.create_nginx_docker_secret  
  ]

  name             = "nginx-plus"
  chart            = "nginx-ingress"
  repository       = "https://helm.nginx.com/stable"
  namespace        = "nginx-ingress"
  create_namespace = true
  wait             = true

  set {
    name  = "controller.nginxplus"
    value = "true"
  }

  set {
    name = "controller.serviceAccount.imagePullSecretName"
    value = "regcred"
  }

  set {
    name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal"
    value = "true"
    type = "string"
  }

  set {
    name = "controller.readyStatus.initialDelaySeconds"
    value = "30"
  }

  set {
    name = "controller.image.repository"
    value =   "private-registry.nginx.com/nginx-ic/nginx-plus-ingress"
  }

  set {
    name = "controller.image.tag"
    value = var.nginx_plus_tag
  }
}