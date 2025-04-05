# Terraform variable values for the 'dev' environment
# Usage: terraform apply -var-file="dev.tfvars"
# Optional: Specify resource group name if you don't want the generated one

resource_group_name = "tfvm-dev-rg"

prefix      = "tfvm"
environment = "dev"

location = "West Europe"

vnet_address_space  = ["10.1.0.0/16"]
subnet_address_prefix = ["10.1.1.0/24"]

# VM Configuration
vm_size        = "Standard_B1s" # Cost-effective size suitable for dev/test
disk_size_gb   = 30
admin_username = "azureuser"

# TODO --- IMPORTANT ---
# Replace the placeholder below with your actual PUBLIC SSH key content.
# You can generate one using `ssh-keygen` if you don't have one.
# Example: Copy the content of ~/.ssh/id_rsa.pub
# this should be stored in secret provider or vault
admin_ssh_key_public = "ssh-rsa XXXXXXXXXXXXXXXXX...." # PASTE YOUR PUBLIC KEY HERE


# Features
enable_monitoring = true # Keep monitoring enabled for dev

# Tags - Customize tags for the dev environment
tags = {
  environment = "Development"
  project     = "TerraformDemo-Dev"
  managedBy   = "Terraform"
  owner       = "DevTeam"
}


