output "cluster_srv_address" {
  value = mongodbatlas_cluster.tastytap_payment.srv_address
}

locals {
  mongodb_server_without_uri = replace(mongodbatlas_cluster.tastytap_payment.srv_address, "mongodb+srv://", "")
}

output "mongo_connection_string" {
  value       = "mongodb+srv://${var.mongo_db_username}:${var.mongo_db_password}@${local.mongodb_server_without_uri}"
  sensitive   = true
}