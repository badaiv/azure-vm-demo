# modules/compute/outputs.tf - Outputs from the compute module

output "vm_id" {
  description = "The ID of the created Virtual Machine."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of the created Virtual Machine."
  value       = azurerm_linux_virtual_machine.vm.name
}

output "public_ip_address" {
  description = "The public IP address assigned to the VM."
  value       = var.create_public_ip ? azurerm_public_ip.pip[0].ip_address : null
  # Note: NSG rules are required to allow access (e.g., SSH port 22).
}

output "private_ip_address" {
  description = "The private IP address assigned to the VM NIC."
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "network_interface_id" {
  description = "The ID of the VM's Network Interface."
  value       = azurerm_network_interface.nic.id
}
