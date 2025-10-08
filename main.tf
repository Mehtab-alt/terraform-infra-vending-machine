// main.tf

# This block configures Terraform itself, specifying the required Azure provider
# and pinning it to a stable version range.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# This block configures the Azure provider. The empty features block is a
# standard boilerplate requirement for this provider.
provider "azurerm" {
  features {}
}

# This is the core instruction of our "machine": "Build a resource group."
# The name, location, and tags are like empty slots waiting for input from
# the control panel (variables.tf) and a preset recipe (.tfvars).
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
