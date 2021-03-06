terraform {
     backend "azurerm" {
            resource_group_name  = "vmssdemo"
    storage_account_name = "ngkcache43345172"
    container_name       = "tfstate"
    access_key                  = "ev5ouV/4s8ozCTmx4Tuj/SztiK+FYGV6RPCV47/O6TvP/P6gasasaasasFBTYDl4/vOVcQqmpM8ln8hvWtU1uqmSQiba0Lg=="
    key = "terraform.tfstate"
      
    }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}


  subscription_id = "xxxxxxxxxx"
  client_id       = "950be8fb-2531-4aea-b4sss4a-54a081213f46"
  client_secret   = "g_77Q~TZ.jcXuHXR5lF2.awWMpdydxSOHhDGc"
  tenant_id       = "6dfb77b4-c9e1-4f45-ba05-02c1592c6232"
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_storage_account" "example" {
  name                     = "ngkstorage451708"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}
resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}
