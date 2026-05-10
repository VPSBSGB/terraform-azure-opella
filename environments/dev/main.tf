locals {
  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "opella"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "dev-eastus-rg"
  location = var.location

  tags = local.common_tags
}

resource "azurerm_virtual_network" "this" {
  name                = "dev-eastus-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.10.0.0/16"]

  tags = local.common_tags
}

resource "azurerm_subnet" "app" {
  name                 = "app"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "db"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.10.2.0/24"]
}
resource "azurerm_network_security_group" "this" {
  name                = "dev-eastus-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.common_tags
}

resource "azurerm_public_ip" "this" {
  name                = "dev-eastus-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"

  tags = local.common_tags
}

resource "azurerm_network_interface" "this" {
  name                = "dev-eastus-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}
/*
resource "azurerm_linux_virtual_machine" "this" {
  name                = "dev-eastus-vm"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = "Standard_A1_v2"

  admin_username = "azureuser"

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = local.common_tags
}
*/

resource "azurerm_storage_account" "this" {
  name                     = "opelladevstorage9273"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.common_tags
}

resource "azurerm_storage_container" "this" {
  name                  = "appdata"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
