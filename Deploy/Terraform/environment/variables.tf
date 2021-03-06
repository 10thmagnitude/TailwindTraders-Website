variable "environment" {
  description = "The environment"
}

variable "apiBaseUrl" {
  description = "Base URL of backend"
  default     = "https://backend.tailwindtraders.com"
}

variable "location" {
  description = "Location of resource"
  default     = "southcentralus"
}

variable "webapp_name" {
  description = "Name of web app"
}

variable "webapp_tier" {
  description = "Tier for web app plan e.g. Free, Basic, Standard etc."
}

variable "webapp_size" {
  description = "Size for web app plan e.g. S1"
}

variable "slotname" {
  description = "Name of slot (if not Free tier)" 
  default     = "staging"
}