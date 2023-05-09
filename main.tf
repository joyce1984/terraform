resource "azurerm_app_service_plan" "example" {
  name                = "${var.name}-asp"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = var.name
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v5.0"
  }
}

output "app_service_id" {
  value = azurerm_app_service.example.id
}
