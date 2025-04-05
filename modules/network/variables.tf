# modules/network/variables.tf - Input variables for the network module

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "CIDR for the Virtual Network."
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Subnet."
  type        = string
}

variable "subnet_address_prefix" {
  description = "CIDR for the Subnet."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to apply to resources."
  type        = map(string)
  default     = {}
}
