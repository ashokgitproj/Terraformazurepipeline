resource "azurerm_resource_group" "rg1" {
  name     = var.rg_name
  location = var.location
}
module "ServicePrincipal" {
  source = "../modules/ServicePrincipal"

  # Pass required variables (adjust these based on your module's variables.tf)
  serviceprincipal_name     = var.serviceprincipal_name         # example variable: service principal name
  
  depends_on = [
    azurerm_resource_group.rg1
  ]