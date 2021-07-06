terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "SonarQube"
  location = "eastus"
}

resource "azurerm_container_group" "example" {
  name                = "SonarQube-Server"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "public"
  dns_name_label      = var.dns-custom-name
  os_type             = "Linux"

  container {
    name   = "sonarqube"
    image  = "sonarqube"
    cpu    = "2"
    memory = "3.5"

    ports {
      port     = 9000
      protocol = "TCP"
    }
  }
}

variable "dns-custom-name" {
  description = "DNS custom para tu instancia de ACI"
  type        = string
}