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
        client_id     = "df934771-9e78-4596-800f-8490d5c1509d"
        client_secret = "aFtYdYo1._fJ8Zf.lxu9YiNYYxBPq3-6.u"
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "kubenet"
    }

    tags = {
        environment = "Curso Telefonica"
    }
}