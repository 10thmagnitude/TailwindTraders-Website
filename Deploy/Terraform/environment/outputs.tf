output "webappURL" {
    value       = azurerm_app_service.webapp.default_site_hostname
    description = "URL of the Web App"
}

output "slotURL" {
    value       = length(azurerm_app_service_slot.slot) == 0 ? azurerm_app_service.webapp.default_site_hostname : azurerm_app_service_slot.slot[0].default_site_hostname
    description = "URL of the Web App slot (or URL of main site if there is none)"
}