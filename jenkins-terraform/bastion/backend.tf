terraform {
  backend "gcs" {
    bucket          = "tfstate-bucket-5-4-2022-02-ideasextraordinarias-default"
    prefix          = "bastion/terraform.tfstate"

  }
}