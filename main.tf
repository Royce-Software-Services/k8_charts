terraform {
  required_version = ">= 0.13.1"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "app" {
  metadata {
    name = var.app_namespace

    annotations = {
      istio-injection : "enabled"
    }
  }
}

resource "helm_release" "app" {
  name = var.app_name

  namespace = kubernetes_namespace.app.metadata.0.name

  cleanup_on_fail = true
  replace         = true
  atomic          = true

  chart = "./charts/app-deploy-template"

  values = [
      "${file("values.yaml")}",
    ]
}