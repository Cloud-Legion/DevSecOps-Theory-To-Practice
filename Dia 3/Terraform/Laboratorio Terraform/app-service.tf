resource "azurerm_resource_group" "demo-rg" {
  name     = "xxxxxx"
  location = "eastus"
}

resource "azurerm_app_service_plan" "app-service-plan" {
  name                = "my-app-service-plan"
  location            = azurerm_resource_group.demo-rg.location
  resource_group_name = azurerm_resource_group.demo-rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "xxxxxx"
    size = "xxxxxxx"
  }
}

resource "azurerm_app_service" "app-service" {
  name                = "xxxxxx"
  location            = azurerm_resource_group.demo-rg.location
  resource_group_name = azurerm_resource_group.demo-rg.name
  app_service_plan_id = azurerm_app_service_plan.app-service-plan.id

  site_config {
    linux_fx_version = "NODE|14-lts"
  }
}  