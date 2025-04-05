Terraform Azure Linux VM Deployment
===================================

This Terraform configuration deploys a standard Linux Virtual Machine  in Azure, along with the necessary networking components. It uses a modular approach for better organization and reusability.

Features
--------

*   Deploys resources in a specified Azure region (default: West Europe).

*   Creates a dedicated Resource Group.

*   Sets up a Virtual Network (VNet) and a Subnet.

*   Provisions a Linux VM (default: Standard\_B1s) with SSH key authentication.

*   Assigns a Static Public IP address to the VM.

*   Optionally installs the Azure Monitor Agent extension for monitoring integration.

*   Uses separate modules for Network (./modules/network) and Compute (./modules/compute) resources.

*   Configuration is parameterized using variables (variables.tf, .tfvars files).


Prerequisites
-------------

1.  **Terraform:** Install Terraform (check required\_providers in main.tf for version constraints, e.g., ~>3.0 for azurerm).

2.  **Azure CLI:** Install Azure CLI and log in using `az login`. Terraform uses these credentials.

3.  **SSH Key Pair:** You need an SSH public/private key pair. If you don't have one, generate it using ssh-keygen -t rsa -b 4096.

4.  **(Optional - Recommended for Teams) Azure Storage Account:** For storing Terraform state remotely and securely. You'll need to create a Storage Account and a container, then configure the backend "azurerm" block in main.tf.


Structure
---------

```   
.  
├── main.tf             # Root module configuration, orchestrates module calls  
├── variables.tf        # Root module variable definitions  
├── outputs.tf          # Root module output definitions  
├── dev.tfvars          # Example variable values for 'dev' environment  
├── modules/  
│   ├── network/  
│   │   ├── main.tf     # Network resources (RG, VNet, Subnet, NSG)  
│   │   ├── variables.tf# Network module inputs  
│   │   └── outputs.tf  # Network module outputs  
│   └── compute/  
│       ├── main.tf     # Compute resources (VM, NIC, Public IP, Extension)  
│       ├── variables.tf# Compute module inputs  
│       └── outputs.tf  # Compute module outputs  
└── README.md           # This file   
└── NOTES.md            # Answers to questions
```

Configuration
-------------

1.  **Variables:** Key configuration parameters are defined in variables.tf. You can override their default values ([dev.tfvars](dev.tfvars))

2.  **Environment Settings:** Create a .tfvars file (e.g., copy dev.tfvars to myenv.tfvars) for your specific deployment environment.

3.  **SSH Key:** **Crucially**, update the admin\_ssh\_key\_public variable in your .tfvars file with the content of your **public** SSH key (e.g., ~/.ssh/id\_rsa.pub).

4.  **Backend:** If using remote state, uncomment and configure the backend "azurerm" block in main.tf with your storage account details.


Usage
-----

1.  **Clone:** Clone this repository (if applicable).

2.  `terraform init`(If using remote state, Terraform will prompt for backend initialization).

3.  `terraform plan -var-file="dev.tfvars"`

4.  `terraform apply -var-file="dev.tfvars"`. Confirm by typing yes when prompted.

5. **Accessing the VM:**

    *   ssh @ -i /path/to/your/private\_key 
    * Example: `ssh azureuser@$(terraform output -raw vm_public_ip_address) -i ~/.ssh/id_rsa`

6. `terraform destroy -var-file="dev.tfvars"`. Confirm by typing yes when prompted.


Modules
-------

*   Network Module ([network](modules/network)): Creates the Resource Group, Virtual Network, and Subnet, Network Security Group.

*   Compute Module ([compute](modules/compute)): Creates the Public IP, Network Interface, Linux Virtual Machine, and installs the Azure Monitor Agent extension (if enabled).


Inputs and Outputs
------------------

Refer to [variables.tf](variables.tf) in the root and module directories for detailed input variable descriptions.

Refer to [outputs.tf](outputs.tf) in the root and module directories for details on the values outputted after a successful apply.