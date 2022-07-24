
provider "azurerm" {
  
  features {
  }
}

terraform {
    backend "azurerm" {
      resource_group_name = "rf_rg_blobstore"
      storage_account_name = "tfstoragetubotonbaharry"
      container_name = "tfstate"
      key = "terraform.tfstate"
    }
    
}

variable "imagebuild" {
  type = string 
  description = "latest image build"
}
 

resource "azurerm_resource_group" "tf_test" {
  name     = "tfmainrg"
  location = "southcentralus"
  tags = {
    environment = "dev"
    source      = "Terraform"
  }
}

resource "azurerm_container_group" "tfcg_test" {
  name="weatherapi"
  location= azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label = "tubotonbaharrywa"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "tubotonbaharry/weatherapi:${var.imagebuild}"
      cpu = "1"
      memory = "1"

      ports {
        port = 80
        protocol = "TCP"
      }
  }
}

