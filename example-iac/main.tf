terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.19.1"
    }
  }
  backend "azurerm" {
  }
  required_version = ">= 1.2"
}

provider "azurerm" {
  features {}
}

locals {
    environment = terraform.workspace
}

resource "azurerm_resource_group" "example" {
  name     = var.azurerm_name-local.environment
  location = var.azurerm_region
}
