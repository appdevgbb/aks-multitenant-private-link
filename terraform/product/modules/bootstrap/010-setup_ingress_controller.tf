resource "null_resource" "create_nginx_ingress_namespace" {

  triggers = {
    kubec_config_hash = "${sha256(base64encode(var.kube_config))}"
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
    kubec_config_hash = "${sha256(base64encode(var.kube_config))}"
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
    name = "controller.image.repository"
    value =   var.image_repository
  }

  set {
    name = "controller.image.tag"
    value = var.nginx_plus_tag
  }

  set {
    name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal"
    value = "true"
    type = "string"
  }

  # set {
  #   name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-backend-protocol"
  #   value = "tcp"
  # }

  set {
    name = "controller.config.entries.proxy-protocol"
    value = "True"
    type = "string"
  }

  set {
    name = "controller.enableSnippets"
    value = "true"
  }
  set {
    name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-loadbalancer-enable-proxy-protocol"
    value = "true"
    type = "string"
  }

  set {
    name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/port_32560_health-probe_protocol"
    value = "tcp"
  }

  set {
    name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/port_32560_health-probe_port"
    value = "32560"
    type = "string"
  }

  # set {
  #   name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-disable-load-balancer-floating-ip	"
  #   value = "true"
  # }

  # set {
  #   name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal-subnet"
  #   value = var.ingress_lb_subnet_name
  # }

  # set {
  #   name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-ipv4"
  #   value = var.ingress_lb_ip
  # }

}