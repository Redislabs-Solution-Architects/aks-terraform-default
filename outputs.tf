locals {
  redisgeek_config = {
    kube_config_raw = azurerm_kubernetes_cluster.redisgeek.kube_config_raw
    kube_config     = azurerm_kubernetes_cluster.redisgeek.kube_config
  }
  rg           = azurerm_resource_group.redisgeek.name
  cluster_name = azurerm_kubernetes_cluster.redisgeek.name
}

output "resource_group" {
  value = azurerm_resource_group.redisgeek.name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.redisgeek.name
}

output "redisgeek_config" {
  value     = jsonencode(local.redisgeek_config)
  sensitive = true
}

output "a_aks_get_credentials" {
  value       = "az aks get-credentials --resource-group  ${local.rg} --name ${local.cluster_name}"
  description = "command to get kube config via az aks cli"
}

output "b_namespace_setup" {
  value = "kubectl create namespace redisgeek"
}

output "c_namespace_config" {
  value = "kubectl config set-context --current --namespace=redisgeek"
}