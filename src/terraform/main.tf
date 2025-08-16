data "azurerm_client_config" "current" {}

resource "random_string" "main" {
  length  = 8
  upper   = false
  special = false
}

locals {
  all_tags = merge(
    {
      application_name = var.application_name
      environment_name = var.environment_name
    },
    var.additional_tags
  )
}

resource "azurerm_resource_group" "main" {
  
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.location
  tags     = local.all_tags

}