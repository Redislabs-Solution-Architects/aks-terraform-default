resource "azurerm_kubernetes_cluster" "redisgeek" {
  name                = format("redisgeek-%s", random_string.aks_cluster_name.id)
  location            = azurerm_resource_group.redisgeek.location
  resource_group_name = azurerm_resource_group.redisgeek.name
  dns_prefix          = random_string.aks_cluster_name.id
  tags                = merge(var.tags, { owner = data.azurerm_client_config.current.client_id })

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D4_v4"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    http_application_routing {
      enabled = true
    }
  }

}
