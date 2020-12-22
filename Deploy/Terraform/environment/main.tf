terraform {
  backend "azurerm" {
    resource_group_name   = "cd-ghactions-demo"
    storage_account_name  = "ghactionstore"
    container_name        = "tfstate"
  }
}

provider "azurerm" {
  version                 = "=2.41.0"
  features {}
}

data "azurerm_resource_group" "main" {
  name                    = "cd-ghactions-demo"
}

resource "azurerm_app_service_plan" "plan" {
  name                    = "cd-ghactions-plan"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name

  sku {
    tier                  = "Standard"
    size                  = "S1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                    = "cdtailwindgha"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  app_service_plan_id     = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version      = "DOTNETCORE|3.1"
    http2_enabled         = true
  }

  app_settings = {
    "ApiUrl"              = "${var.apiBaseUrl}/webbff/v1"
    "ApiUrlShoppingCart"  = "${var.apiBaseUrl}/cart-api"
  }
}

resource "azurerm_app_service_slot" "slot" {
  name                    = "DEV"
  app_service_name        = azurerm_app_service.webapp.name
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  app_service_plan_id     = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version      = "DOTNETCORE|3.1"
    http2_enabled         = true
  }
}