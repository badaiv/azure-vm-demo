# modules/compute/variables.tf - Input variables for the compute module

variable "resource_group_name" {
  description = "Name of the Azure Resource Group where the VM will be created."
  type        = string
}

variable "location" {
  description = "Azure region for the VM deployment."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the Subnet where the VM's NIC will be attached."
  type        = string
}

variable "vm_name" {
  description = "Name of the Virtual Machine."
  type        = string
}

variable "vm_size" {
  description = "The size (SKU) of the Virtual Machine."
  type        = string
}

variable "vm_storage_account_type" {
  description = "The type of storage account to use for the VM's OS disk."
  type        = string
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "The size of the OS disk in gigabytes."
  type        = number
  default     = 30
}

variable "vm_source_image_reference" {
  description = "Source image reference for the VM."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "admin_username" {
  description = "Administrator username for the Linux VM."
  type        = string
}

variable "admin_ssh_key_public" {
  description = "Public SSH key content for VM authentication."
  type        = string
  sensitive   = true
}

variable "enable_monitoring" {
  description = "Flag to enable/disable the Azure Monitor Agent installation."
  type        = bool
  default     = true
}

variable "create_public_ip" {
  description = "Flag to create a public IP address for the VM."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to apply to resources."
  type        = map(string)
  default     = {}
}
