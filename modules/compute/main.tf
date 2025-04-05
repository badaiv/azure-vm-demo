# modules/compute/main.tf - Defines compute resources (VM, NIC, Public IP, Extension)

# Public IP Address (Optional but needed for direct SSH access from internet)
resource "azurerm_public_ip" "pip" {
  count               = var.create_public_ip ? 1 : 0
  name                = "${var.vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Network Interface (NIC)
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.pip[0].id : null # Associate Public IP if created
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  tags = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key_public
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  # Specify a common Linux distribution image
  source_image_reference {
    publisher = var.vm_source_image_reference.publisher
    offer     = var.vm_source_image_reference.offer
    sku       = var.vm_source_image_reference.sku
    version   = var.vm_source_image_reference.version
  }
}

# Azure Monitor Agent Extension
# Installs the agent required for Azure Monitor features like VM Insights, Log Analytics data collection
resource "azurerm_virtual_machine_extension" "ama_linux" {
  count = var.enable_monitoring ? 1 : 0

  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.29"
  auto_upgrade_minor_version = true

  # Settings are minimal here; typically configured via Data Collection Rules (DCRs) in Azure Portal/CLI/Terraform
  settings = jsonencode({}) # Empty settings, agent will use default or DCR config

  tags = var.tags
}
