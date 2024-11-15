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
  identifier             = "tastytap_users"
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