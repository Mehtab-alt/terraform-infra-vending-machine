# The Terraform Infrastructure Vending Machine

This project is a professional template for managing multiple environments (e.g., dev, prod) with Terraform. It demonstrates best practices for state isolation, team collaboration, and security.

The core concept is a "Vending Machine" for infrastructure:
- **`main.tf`**: The internal mechanism that builds resources.
- **`variables.tf`**: The control panel defining all available options.
- **Terraform Workspaces**: Isolated "tanks" that keep each environment's state (`dev`, `prod`) completely separate, preventing dangerous cross-contamination.
- **`.tfvars` files**: The specific "recipes" for each environment.

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed.
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and authenticated (`az login`).

## 1. One-Time Backend Setup (Crucial for Teams)

Before you can use this project, you must set up a remote backend to store the Terraform state file. This ensures everyone on the team is working with the same state. **You only need to do this once per project.**

1.  **Log into Azure:**
    ```bash
    az login
    ```

2.  **Create a dedicated Resource Group for the state file:**
    ```bash
    az group create --name tfstate-rg --location "East US"
    ```

3.  **Create a Storage Account. It must have a globally unique name:**
    ```bash
    # Replace the suffix with your own unique characters
    STORAGE_ACCOUNT_NAME="tfstate$(openssl rand -hex 3)"
    az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group tfstate-rg --sku Standard_LRS --encryption-services blob
    ```

4.  **Create a Blob Container within the Storage Account:**
    ```bash
    az storage container create --name tfstate --account-name $STORAGE_ACCOUNT_NAME
    ```

5.  **Update `backend.tf`:**
    In the `backend.tf` file, replace `tfstate<UNIQUE_SUFFIX>` with the unique storage account name you just created.

## 2. Local Environment Configuration

This project uses a secure pattern where secret/configuration files are not committed to Git.

1.  **Create a `dev.tfvars` file:**
    ```bash
    cp dev.tfvars.example dev.tfvars
    ```
2.  **Create a `prod.tfvars` file:**
    ```bash
    cp prod.tfvars.example prod.tfvars
    ```
    *(You can customize the values in these new files if needed. They are already ignored by `.gitignore`.)*

## 3. How to Operate the Machine (Using Workspaces)

This project uses Terraform Workspaces to manage environments. Each workspace has its own independent state file.

### Step 1: Initialize Terraform

Navigate to the project directory. This one-time command initializes Terraform and connects it to the remote backend you configured.

```bash
terraform init
