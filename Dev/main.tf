resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location
}
module "ServicePrincipal" {
  source = "../modules/ServicePrincipal"

  # Pass required variables (adjust these based on your module's variables.tf)
  serviceprincipal_name     = var.serviceprincipal_name         # example variable: service principal name
  
  depends_on = [
    azurerm_resource_group.rg1
  ]
resource "azurerm_role_assignment" "rolespn" {
  scope                = /subscriptions/${var.SUB_ID}
  role_definition_name = "Contributor"
  principal_id         = module.ServicePrincipal.service_principal_id

  depends_on = [
    module.ServicePrincipal
  ]
}

module "KeyVault" {
  source              = "../module/keyvault"
  key_vault_name      = "var.keyvault_name"
  resource_group_name = "var.rgname"
  location            = "var.location"
  serviceprincipal_name     = var.serviceprincipal_name
  serviceprincipal_tenant_id = module.ServicePrincipal.service_principal_tenant_id
  serviceprincipal_object_id = module.ServicePrincipal.service_principal_object_id

  depends_on = [
    module.ServicePrincipal
  ]
}