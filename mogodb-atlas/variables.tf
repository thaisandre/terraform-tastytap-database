variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_id" {
  description = "MongoDB Atlas project ID"
  type        = string
}

variable mongodbatlas_public_key {
  description = "MongoDB Atlas public key"
  type        = string
}

variable mongodbatlas_private_key {
  description = "MongoDB Atlas private key"
  type        = string
}

variable "mongo_db_username" {
  description = "MongoDB username"
  type        = string
}

variable "mongo_db_password" {
  description = "MongoDB password"
  type        = string
}

variable "atlas_cluster_allow_inbound_from_cidr" {
  description = "CIDR block to allow inbound traffic to the cluster"
  type        = string
  default     = "0.0.0.0/0"
}