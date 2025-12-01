resource "azurerm_resource_group" "rg" {
  name     = "dessy-rg1"
  location = "East US"
}

resource "azurerm_storage_account" "dessystorage" {
  name                     = "dessystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_kubernetes_cluster" "dessyaks" {
  name                = "dessy-aks1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "dessyaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v3"
  }
  identity {
    type = "SystemAssigned"
 }
  tags = {
    Environment = "demo"
  }
}
