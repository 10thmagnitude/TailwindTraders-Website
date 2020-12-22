variable "prefix" {
  description = "The prefix used for all resources"
  default     = "cd"
}

variable "environment" {
  description = "The environment"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  default     = "southcentralus"
}

variable "apiBaseUrl" {
  description = "Base URL of backend"
  default     = "https://backend.tailwindtraders.com/"
}