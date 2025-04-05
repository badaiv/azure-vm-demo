# Root main.tf - Orchestrates module deployment

# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0" # Use a recent stable version
    }
  }
  # Recommended: Configure remote state backend for team collaboration
  # backend "azurerm" {
  #   resource_group_name  = "tfstate-rg"
  #   storage_account_name = "tfstatestorageaccount" # Must be globally unique
  #   container_name       = "tfstate"
  #   key                  = "prod.terraform.tfstate" # Example key, adjust per environment
  # }
}

provider "azurerm" {
  features {}
}

# --- Network Module ---
# Deploys the core networking components (Resource Group, VNet, Subnet)
# Ideally subnets should be created in different zones for high availability
module "network" {
  source = "./modules/network" # Path to the network module

  resource_group_name   = var.resource_group_name
  location              = var.location
  vnet_name             = "${var.prefix}-${var.environment}-vnet"
  vnet_address_space    = var.vnet_address_space
  subnet_name           = "${var.prefix}-${var.environment}-subnet"
  subnet_address_prefix = var.subnet_address_prefix
  tags                  = var.tags
}

# --- Compute Module ---
# Deploys the Virtual Machine and related resources (NIC, Public IP, Monitoring Extension)
module "compute" {
  source = "./modules/compute" # Path to the compute module

  resource_group_name  = module.network.resource_group_name
  location             = module.network.location
  subnet_id            = module.network.subnet_id
  vm_name              = "${var.prefix}-${var.environment}-vm"
  vm_size              = var.vm_size
  disk_size_gb         = var.disk_size_gb
  admin_username       = var.admin_username
  admin_ssh_key_public = var.admin_ssh_key_public
  enable_monitoring    = var.enable_monitoring
  create_public_ip     = true
  tags                 = var.tags

  depends_on = [module.network]
}
