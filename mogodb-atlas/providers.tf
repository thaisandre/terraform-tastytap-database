terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.00"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

provider "mongodbatlas" {
  public_key  = var.mongodbatlas_public_key
  private_key = var.mongodbatlas_private_key
}