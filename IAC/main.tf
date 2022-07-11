# Definiendo el proveedor y la región
provider "aws" {
        region = "us-east-1"
}

# Creando los usuarios de IAM con nombres diferentes
resource "aws_iam_user" "accounts" {
  for_each = toset( ["Account1", "Account2"] )
  name = each.key
}

# Creando la base de datos
resource "aws_db_instance" "default" {
  #nombre de la BD RDS
  identifier = "mibd-rds-demo"
  #almacenamiento
  allocated_storage = 25
  storage_type = "gp2"
  #motor BD
  engine = "postgres"
  engine_version = "12.9"
  #familia
  instance_class = "db.t3.micro"
  #detalles DB
  db_name = "mi_bd_demo"
  username = "juancondorijara"
  password = "CondoriJara2020"
  skip_final_snapshot = true
  #etiquetas
  tags = {
    Name = "terraform_dev_rds-demo"
    Environment = "dev-demo"
  }
}

# Creando VPC 
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}

# Creando SUBNET
resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "mysubnet"
  }
}
