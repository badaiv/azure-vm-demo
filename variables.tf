# Root variables.tf - Define input variables for the root configuration

variable "prefix" {
  description = "A prefix used for naming resources (e.g., 'myapp')."
  type        = string
  default     = "tfvm"
}

variable "environment" {
  description = "The deployment environment (e.g., 'dev', 'staging', 'prod')."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Optional: Specific name for the resource group. If empty, a name is generated using prefix and environment."
  type        = string
  default     = ""
}

variable "vnet_address_space" {
  description = "The address space for the Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "The address prefix for the Subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vm_size" {
  description = "The size (SKU) of the Virtual Machine."
  type        = string
  default     = "Standard_B1s" # Cost-effective burstable size, good for dev/test
}

variable "disk_size_gb" {
    description = "The size of the OS disk in gigabytes."
    type        = number
    default     = 30 # Default size for the OS disk
}

variable "admin_username" {
  description = "The administrator username for the Linux VM."
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_key_public" {
  description = "The public SSH key content used for authentication to the VM."
  type        = string
  sensitive   = true # Mark as sensitive to avoid showing in logs/outputs
  # Ensure you provide a valid public key value, e.g., via a .tfvars file or environment variable
  # Example: TF_VAR_admin_ssh_key_public=$(cat ~/.ssh/id_rsa.pub) terraform apply
  validation {
    condition     = substr(var.admin_ssh_key_public, 0, 7) == "ssh-rsa" || substr(var.admin_ssh_key_public, 0, 7) == "ssh-ed2" || substr(var.admin_ssh_key_public, 0, 7) == "ecdsa-s"
    error_message = "The admin_ssh_key_public value must be a valid SSH public key starting with 'ssh-rsa', 'ssh-ed25519', or 'ecdsa-sha2-nistp'."
  }
}

variable "enable_monitoring" {
  description = "If set to true, installs the Azure Monitor Agent extension on the VM."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "Development"
    project     = "TerraformDemo"
    managedBy   = "Terraform"
  }
}
