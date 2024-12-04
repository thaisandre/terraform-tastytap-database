variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "tastytap-cluster"
}

variable "tastytap_db_name" {
  description = "RDS tastytap database name"
  type        = string
  default     = "tastytap"
}

variable "tastytap_db_username" {
  description = "RDS tastytap database username"
  type        = string
  default     = "db_username"
}

variable "tastytap_db_password" {
  description = "RDS tastytap database password"
  type        = string
  default     = "db_password"
}

variable "users_db_name" {
  description = "RDS users database name"
  type        = string
  default     = "users"
}

variable "users_db_username" {
  description = "RDS users database username"
  type        = string
  default     = "db_username"
}

variable "users_db_password" {
  description = "RDS users database password"
  type        = string
  default     = "db_password"
}

variable "project_id" {
  description = "MongoDB Atlas project ID"
  type        = string
}

variable "mongodbatlas_public_key" {
  description = "MongoDB Atlas public key"
  type        = string
}

variable "mongodbatlas_private_key" {
  description = "MongoDB Atlas private key"
  type        = string
}

variable "mongo_db_username" {
  description = "MongoDB username"
  type        = string
  default     = "admin"
}

variable "mongo_db_password" {
  description = "MongoDB password"
  type        = string
  default     = "admin"
}

variable "atlas_cluster_allow_inbound_from_cidr" {
  description = "CIDR block to allow inbound traffic to the cluster"
  type        = string
  default     = "0.0.0.0/0"
}
