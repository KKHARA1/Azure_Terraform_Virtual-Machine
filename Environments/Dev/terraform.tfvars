rgs = {
  rg1 = {
    name       = "Devrgproject"
    location   = "centralindia"
    managed_by = "Terraform"
    tags = {
      env = "dev1"
    }
  }

  rg2 = {
    name     = "Devrgproject2"
    location = "centralindia"
    tags = {
      env = "dev2"
    }
  }
}

stg = {
  stg1 = {
    name                     = "devstgproject123"
    resource_group_name      = "Devrgproject"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "staging"
    }

  }
}


vnet = {
  vnet1 = {
    name                = "kkvnet"
    location            = "centralindia"
    resource_group_name = "Devrgproject"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]

    subnets = [
      {
        name             = "frontend_subnet"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        name             = "backend_subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    ]

  }

}

pip = {
  pip1 = {
    name                = "frontend_pip"
    resource_group_name = "Devrgproject"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      environment = "Dev_frontend"
    }
  }
  # pip2 = {
  #     name                = "backend_pip"
  #   resource_group_name = "Devrgproject"
  #   location            = "centralindia"
  #   allocation_method   = "Static"
  #   tags = {
  #     environment = "Dev_backend"
  #   }  
  #   }

}

vms = {
  vm1 = {
    subnet_name          = "frontend_subnet"
    virtual_network_name = "kkvnet"
    resource_group_name  = "Devrgproject"
    pip_name             = "frontend_pip"
    nic_name             = "frontend_nic"
    location             = "centralindia"
    ip_configuration = [
      {
        ip_configurationname          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    ]
    vmname                          = "frontend-VM"
    size                            = "Standard_B1s"
    kvname                          = "kv-vm1-front-todo"
    kvusername                      = "username23"
    kvuserpass                      = "userpassword34"
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

  }

  # vm2 = {
  #  subnet_name = "backend_subnet"
  # virtual_network_name = "kkvnet"
  # resource_group_name = "Devrgproject"
  # pip_name = "backend_pip"
  # nic_name = "backend_nic"
  # location = "centralindia"
  # ip_configuration = [
  #   {
  #   ip_configurationname = "internal"
  #   private_ip_address_allocation = "Dynamic"
  # }
  # ]
  #  }


}


kv = {
  kv1 = {
    kvname                      = "kv-vm1-front-todo"
    location                    = "centralindia"
    resource_group_name         = "Devrgproject"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    access_policies = [

      {

        key_permissions = [
          "Get",
        ]

        secret_permissions = [
          "Backup",
          "Delete",
          "Get",
          "List",
          "Purge",
          "Recover",
          "Restore",
          "Set"
        ]

        storage_permissions = [
          "Get",
        ]

      }
    ]

  }

}

kvsecrets = {

  kvsecret1 = {
    kvname              = "kv-vm1-front-todo"
    resource_group_name = "Devrgproject"
    kvsecretsname       = "usernamevm23"
    kvsecretvalue       = "kkvmtodo"
  }

  kvsecret2 = {
    kvname              = "kv-vm1-front-todo"
    resource_group_name = "Devrgproject"
    kvsecretsname       = "userpasswordvm34"
    kvsecretvalue       = "Devops@1234567"
  }

}



nsg = {
  nsg1 = {
    nicname             = "frontend_nic"
    nsgname             = "nsg-frontend"
    location            = "centralindia"
    resource_group_name = "Devrgproject"
    security_rules = [
      {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]

  }
}

sqlservers = {

  sqlserver1 = {
    sqlservername                = "dev-sqlsrver"
    resource_group_name          = "Devrgproject"
    location                     = "centralindia"
    version                      = "12.0"
    administrator_login          = "kksqlserv"
    administrator_login_password = "Passwoe@123"
    sqldbname                    = "dev-sqldb"
    collation                    = "SQL_Latin1_General_CP1_CI_AS"
    license_type                 = "LicenseIncluded"
    max_size_gb                  = 2
    sku_name                     = "S0"
    enclave_type                 = "VBS"
  }

}
