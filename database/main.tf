data "aws_secretsmanager_secret_version" "username" {
  secret_id = var.secret_id
}

resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  identifier = var.identifier
  engine               = var.engine
  engine_version = var.engine_version
  instance_class       = var.instance_class
  publicly_accessible = var.publicly_accessible
  username             = jsondecode(data.aws_secretsmanager_secret_version.username.secret_string).POSTGRES_USERNAME
  password = jsondecode(data.aws_secretsmanager_secret_version.username.secret_string).POSTGRES_PASSWORD
  skip_final_snapshot = var.skip_final_snapshot
}