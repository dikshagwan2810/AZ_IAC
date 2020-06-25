resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "snet1" {
  name                 = var.snet1_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.snet1_cidr]
  depends_on = [azurerm_virtual_network.vnet]
}
resource "azurerm_subnet" "snet2" {
  name                 = "var.snet2_name"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.snet2_cidr]
  depends_on = [azurerm_subnet.snet2]
}
resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  sku                      = "basic"
  admin_enabled            = true
}
resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = var.client_id
  skip_service_principal_aad_check = true
}
resource "azurerm_role_assignment" "snetakscontributerole" {
  scope                            = azurerm_virtual_network.vnet.id
  role_definition_name             = "Contributor"
  principal_id                     = var.client_id
  skip_service_principal_aad_check = true
}
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    depends_on = [azurerm_subnet.snet1]
    name                = var.aks_name
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix          = "udx"
    linux_profile {
        admin_username = "ubuntu"
        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }
    default_node_pool {
        name            = "agentpool"
        node_count      = var.aks_node_count
        vm_size         = var.aks_node_size
        type            = "VirtualMachineScaleSets"
        vnet_subnet_id = azurerm_subnet.snet1.id
    }
    service_principal {
        client_id     = var.client_id
        client_secret = var.client_secret
    }
    tags = {
        Environment = terraform.workspace
    }
  network_profile {
          dns_service_ip     = "31.0.0.10"
          docker_bridge_cidr = "172.17.0.1/16"
          load_balancer_sku  = "standard"
          network_plugin     = "azure"
          network_policy     = "calico"
          #outbound_type      = (known after apply)
          #pod_cidr           = (known after apply)
          service_cidr       = "31.0.0.0/16"
        }
} 



