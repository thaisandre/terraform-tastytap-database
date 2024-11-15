resource "mongodbatlas_database_user" "db-user" {
  auth_database_name = var.mongo_db_username
  username           = var.mongo_db_username
  password           = var.mongo_db_password
  project_id         = var.project_id

  roles {
    role_name     = "readWrite"
    database_name = "payment"
  }
}

resource "mongodbatlas_cluster" "tastytap_payment" {
  project_id                  = var.project_id
  name                        = "mongodb-tastytap-cluster"
  cluster_type                = "REPLICASET"
  
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "US_EAST_1"
  provider_instance_size_name = "M0"
}

resource "mongodbatlas_project_ip_access_list" "ip_access_list" {
  project_id = var.project_id
  cidr_block = var.atlas_cluster_allow_inbound_from_cidr
}