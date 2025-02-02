provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "East US"
}

# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = "smsstorageaccountkanthams"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Add a resource lock to the resource group
resource "azurerm_management_lock" "rg_lock" {
  name       = "xyz-lock-name"  # Replace with your desired lock name
  scope      = azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"   # Options: "CanNotDelete" or "ReadOnly"
}