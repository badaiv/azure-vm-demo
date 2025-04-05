# Root outputs.tf - Define outputs from the root configuration

output "resource_group_name" {
  description = "The name of the resource group."
  value       = module.network.resource_group_name
}

output "location" {
  description = "The Azure region where resources are deployed."
  value       = module.network.location
}

output "virtual_network_name" {
  description = "The name of the Virtual Network."
  value       = module.network.vnet_name
}

output "subnet_name" {
  description = "The name of the Subnet."
  value       = module.network.subnet_name
}

output "vm_name" {
  description = "The name of the Virtual Machine."
  value       = module.compute.vm_name
}

output "vm_id" {
  description = "The ID of the Virtual Machine."
  value       = module.compute.vm_id
}

output "vm_public_ip_address" {
  description = "The public IP address assigned to the VM (if any)."
  value       = module.compute.public_ip_address
}

output "vm_private_ip_address" {
  description = "The private IP address assigned to the VM."
  value       = module.compute.private_ip_address
}

output "monitoring_agent_installed" {
  description = "Indicates if the Azure Monitor Agent was installed."
  value       = var.enable_monitoring
}
