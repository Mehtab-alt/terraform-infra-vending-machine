// backend.tf

# This block configures Terraform to store its state file remotely in an
# Azure Storage Account. This is CRITICAL for team collaboration.
# It enables state locking to prevent concurrent modifications and provides a
# single source of truth for the infrastructure's state.

terraform {
  backend "azurerm" {
    # These values will be configured during the 'terraform init' step.
    # You will create these resources in the "One-Time Backend Setup" below.
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate<UNIQUE_SUFFIX>"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
