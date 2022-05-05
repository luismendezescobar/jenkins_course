terraform {
  backend "gcs" {
    bucket          = "tfstate-bucket-5-4-2022-01-ideasextraordinarias-default"
    prefix          = "bastion/terraform.tfstate"

  }
}