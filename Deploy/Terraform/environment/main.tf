terraform {
  backend "azurerm" {
    resource_group_name   = "cd-ghactions-demo-shared"
    storage_account_name  = "ghactiondemostore"
    container_name        = "tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name                    = "cd-ghactions-demo-${var.environment}"
  location                = var.location    
}

resource "azurerm_app_service_plan" "plan" {
  name                    = "cd-ghactions-plan-${var.environment}"
  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  kind                    = "Linux"
  reserved                = true

  sku {
    tier                  = var.webapp_tier
    size                  = var.webapp_size
  }
}

resource "azurerm_app_service" "webapp" {
  name                    = var.webapp_name
  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
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
  count                   = var.webapp_tier == "Free" ? 0 : 1
  name                    = var.slotname
  app_service_name        = azurerm_app_service.webapp.name
  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  app_service_plan_id     = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version      = "DOTNETCORE|3.1"
    http2_enabled         = true
  }
}