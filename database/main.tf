provider "aws" {
  region = var.region
}

locals {
  vpc_name = "tastytap-vpc"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${local.vpc_name}-public"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${local.vpc_name}-private"]
  }
}

resource "aws_security_group" "tasytap-db-sg" {
  name_prefix = "tastytap-db-"
  description = "Allow access to RDS"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "tastytap-rds-subnet-group" {
  name        = "tastytap-rds-subnet-group"
  description = "RDS subnet group for tastytap"
  subnet_ids  = data.aws_subnets.public.ids

  tags = {
    Name = "tastytap-rds-subnet-group"
  } 
}

resource "aws_db_instance" "tastytap" {
  identifier             = "tastytap"
  allocated_storage      = 10
  instance_class         = "db.t3.micro"
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  db_name                = var.tastytap_db_name
  username               = var.tastytap_db_username
  password               = var.tastytap_db_password
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.tasytap-db-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.tastytap-rds-subnet-group.name

  tags = {
    Name = "tastytap"
  }
}

resource "aws_db_instance" "users" {
  identifier             = "tastytap-users"
  allocated_storage      = 10
  instance_class         = "db.t3.micro"
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  db_name                = var.users_db_name
  username               = var.users_db_password
  password               = var.users_db_password
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.tasytap-db-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.tastytap-rds-subnet-group.name

  tags = {
    Name = "tastytap_users"
  }
}

provider "mongodbatlas" {
  public_key  = var.mongodbatlas_public_key
  private_key = var.mongodbatlas_private_key
}

resource "mongodbatlas_database_user" "db-user" {
  auth_database_name = var.mongo_db_username
  username           = var.mongo_db_username
  password           = var.mongo_db_password
  project_id         = var.project_id

  roles {
    role_name     = "readWrite"
    database_name = "tastytap"
    collection_name = "payments"
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