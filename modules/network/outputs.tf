# modules/network/outputs.tf - Outputs from the network module

output "resource_group_name" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "The location of the created resource group."
  value       = azurerm_resource_group.rg.location
}

output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  description = "The ID of the Subnet."
  value       = azurerm_subnet.subnet.id
}

output "subnet_name" {
  description = "The name of the Subnet."
  value       = azurerm_subnet.subnet.name
}
