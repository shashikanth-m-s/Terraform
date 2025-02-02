provider "azurerm" {
  features {}
}
 
# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "sms-rg-tf"
  location = "East US"
}
 
# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = "smsstrgtf"
resource_group_name = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
 
# Add a resource lock to the resource group
resource "azurerm_management_lock" "rg_lock" {
  name       = "sms-lock"  # Lock for the resource group
scope = azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"   # Options: "ReadOnly"
}
 
# Add a resource lock to the storage account
resource "azurerm_management_lock" "storage_lock" {
  name       = "sms-lock"  # Lock for the storage account
scope = azurerm_storage_account.storage.id
  lock_level = "ReadOnly"       # Options: "CanNotDelete" 
}
 
