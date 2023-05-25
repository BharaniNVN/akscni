terraform {
  required_version = "~> 1.4.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.50.0"
    }
  }

}

provider "azurerm" {
  client_id                  = "78615c37-4c54-449c-96cd-512dff8b1aaf"
  client_secret              = "9GR8Q~z.nemxmfHnoLk6wmGaObCuSCIcbvqKIb4B" #Passing value as ENV Varaible from Pipeline
  tenant_id                  = "cc7484f9-3c91-4b30-bb1b-4d8491a1c94c"
  subscription_id            = "2c4c8c51-ea6d-46c2-a433-f19805a98cbc"
  skip_provider_registration = true

  features {}
}