terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.00"
    }

    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }

  backend "remote" {
    organization = "tastytap"

    workspaces {
        prefix = "terraform-tastytap-"
    }
  }
}