terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a007343f-c19e-4777-9015-909bbeddda2b"
}

module "rg" {
  source = "./rg"
}

module "vnet" {
  source = "./vnet"
  depends_on = [ module.rg ]
  resource_group_name= module.rg.rg_name
}
module "subnet" {
  source = "./subnet"
  depends_on = [ module.vnet ]
  resource_group_name= module.rg.rg_name
  virtual_network_name=module.vnet.subnet
}

module "vm" {
  source = "./vm"
  depends_on = [ module.subnet ]
  resource_group_name= module.rg.rg_name
  subnet_id = module.subnet.resourse1
  
}