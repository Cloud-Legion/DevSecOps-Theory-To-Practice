resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "kubernetes-demo"
    location            = azurerm_resource_group.myterraformgroup.location
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    dns_prefix          = "kubernetes-demo"

    default_node_pool {
        name            = "agentpool"
        node_count      = "3"
        vm_size         = "Standard_B2s"
    }

    service_principal {
        client_id     = ""
        client_secret = ""
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "kubenet"
    }

    tags = {
        environment = "DevSecOps-Theory-To-Practice"
    }
}