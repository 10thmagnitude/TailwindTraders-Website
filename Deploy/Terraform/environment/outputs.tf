output "webappURL" {
    value       = azurerm_app_service.webapp.default_site_hostname
    description = "URL of the Web App"
}

output "slotURL" {
    value       = "${azurerm_app_service.webapp.default_site_hostname}-${azurerm_app_service_slot.slot.name}"
    description = "URL of the Web App slot"
}