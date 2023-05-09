variable "name" {
  type = string
}
variable "resourcegroupname" {
  type = string
}
variable "location" {
  type = string
}

resource "azurerm_resource_group" "example" {
  name     = var.resourcegroupname
  location = var.location
}

resource "azurerm_app_service_plan" "example" {
  name                = "${var.name}-asp"
  location            = var.location
  resource_group_name = var.resourcegroupname
  sku {
    tier = "Standard"
    size = "S1"
  }
  
   depends_on = [
    azurerm_resource_group.example
  ]
}

resource "azurerm_app_service" "example" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resourcegroupname
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v5.0"
  }
  
   depends_on = [
    azurerm_app_service_plan.example
  ]
}

output "app_service_id" {
  value = azurerm_app_service.example.id
}
