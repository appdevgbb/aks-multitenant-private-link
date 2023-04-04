terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "azurerm" {
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}


locals {
    myip = "${trimspace(data.http.myip.response_body)}/32"
}