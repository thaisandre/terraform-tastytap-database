output "tastytap_db_instance_endpoint" {
  description = "The endpoint of the RDS tastytap instance"
  value       = aws_db_instance.tastytap.endpoint
}

output "tastytap_db_instance_id" {
  description = "The id of the tastytap db instance"
  value       = aws_db_instance.tastytap.id
}

output "tastytap_db_instance_name" {
  description = "The name of the tastytap db instance"
  value       = aws_db_instance.tastytap.db_name
}

output "users_db_instance_endpoint" {
  description = "The endpoint of the RDS users instance"
  value       = aws_db_instance.users.endpoint
}

output "users_db_instance_id" {
  description = "The id of the users db instance"
  value       = aws_db_instance.users.id
}

output "users_db_instance_name" {
  description = "The name of the users db instance"
  value       = aws_db_instance.users.db_name
}