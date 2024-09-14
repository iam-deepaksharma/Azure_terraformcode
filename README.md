# Terraform Infrastructure Setup

This repository contains Terraform code to provision basic infrastructure components on [your cloud provider, e.g., Azure/AWS/GCP]. Specifically, it includes:

- Storage Account
- Virtual Network (VNET)
- Subnet
- Virtual Machine (VM)
- Load Balancer (LB)

## Overview

This Terraform configuration sets up a basic network and compute infrastructure with a load balancer to distribute traffic across virtual machines. This setup is ideal for creating a scalable, fault-tolerant architecture.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (version 1.0 or later)
- Access to your cloud provider account (e.g., AWS, Azure, GCP)
- Appropriate IAM permissions to create resources

## Getting Started

### Clone the Repository

git clone https://github.com/your-username/terraform-infrastructure.git
cd terraform-infrastructure

**Configure Your Provider**
Update the provider configuration in main.tf with your credentials and desired region. For example, for AWS:

**Initialize Terraform**
Run terraform init to initialize the Terraform working directory and download required providers.
terraform init

**Plan the Deployment**
Run terraform plan to create an execution plan. This will show you what Terraform intends to do without making any changes.
terraform plan

**Apply the Configuration**
Apply the configuration to create the infrastructure. Terraform will prompt for confirmation before making changes.
terraform apply

**Verify Resources**
After applying the configuration, you can verify that the resources have been created in your cloud provider's management console.

**Configuration Files**
main.tf: Contains the main Terraform configuration including VNET, Subnet, VM, and LB setup.
variables.tf: Defines variables used in the configuration.
outputs.tf: Specifies output values that Terraform will display after applying the configuration.
terraform.tfvars: (Optional) Allows you to specify values for variables.

**Variables**
The following variables can be customized in terraform.tfvars or via environment variables:

region: The region where resources will be created.
vm_instance_type: The type of VM instance to provision.
vnet_name: Name of the virtual network.
subnet_name: Name of the subnet.
lb_name: Name of the load balancer.

**Outputs**
After successful deployment, the following outputs will be displayed:
vm_ip_address: The public IP address of the provisioned VM.
lb_dns_name: The DNS name of the load balancer.

**Clean Up**
To destroy the resources created by this configuration, run:
