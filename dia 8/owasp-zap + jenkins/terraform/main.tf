# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "Jenkins-ZAP"
    location = "centralus"

    tags = {
        environment = "DevSecOps-Theory-To-Practice"
    }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "Jenkins-ZAP-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "centralus"
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    tags = {
        environment = "DevSecOps-Theory-To-Practice"
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "Jenkins-ZAP-subnet"
    resource_group_name  = azurerm_resource_group.myterraformgroup.name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes       = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "Jenkins-ZAP-public-ip"
    location                     = "centralus"
    resource_group_name          = azurerm_resource_group.myterraformgroup.name
    allocation_method            = "Static"

    tags = {
        environment = "DevSecOps-Theory-To-Practice"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "Jenkins-ZAP-sg"
    location            = "centralus"
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    security_rule {
        name                       = "All"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "DevSecOps-Theory-To-Practice"
    }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    name                      = "Jenkins-ZAP-nic"
    location                  = "centralus"
    resource_group_name       = azurerm_resource_group.myterraformgroup.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = "DevSecOps-Theory-To-Practice"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

# Map data for cloud init
data "template_file" "cloud_config" {
  template = file("jenkins-ZAP-server.sh")
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = "Jenkins-ZAP-server"
    location              = "centralus"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [azurerm_network_interface.myterraformnic.id]
    size                  = "Standard_B2s"

    os_disk {
        name              = "Jenkins-ZAP-osdisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts-gen2"
        version   = "latest"
    }

    computer_name  = "Jenkins-ZAP-server"
    admin_username = "azureuser"
    admin_password = "Password1234!"
    disable_password_authentication = false
    custom_data    = "${base64encode(data.template_file.cloud_config.rendered)}"

    tags = {
        environment = "DevSecOps-Theory-To-Practice"
    }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "myterraformgroup" {
  virtual_machine_id = azurerm_linux_virtual_machine.myterraformvm.id
  location           = azurerm_resource_group.myterraformgroup.location
  enabled            = true

  daily_recurrence_time = "2015"
  timezone              = "Argentina Standard Time"

  notification_settings {
    enabled         = false
  }
}

output "ipaddres" {
      description = "IP Publica es:"
      value = azurerm_public_ip.myterraformpublicip.ip_address
       }
