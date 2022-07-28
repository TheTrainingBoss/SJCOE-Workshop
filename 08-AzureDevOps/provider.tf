terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "0.2.2"
    }
  }
}

provider "azuredevops" {
  personal_access_token = "tc6zmog76efcxexhqvqaivrcexud32y35ax5zsddfxjn7vkq3hoa"
  org_service_url = "https://thetrainingbossgmail.visualstudio.com/"
}