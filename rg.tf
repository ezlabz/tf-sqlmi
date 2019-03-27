# Create a resource group
resource "azurerm_resource_group" "sqlmirg" {
  name     = "${var.AppName}${var.LOB}sqlmirg"
  location = "${var.azure_region}"
}