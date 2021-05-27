resource "aws_db_instance" "mysql-instance" {
  identifier = "${var.client_name}-${var.environment}-db"
  instance_class = "${var.db_instance_class}"
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  engine = "mysql"
  engine_version = "5.7"
  username             = var.master_user
  password             = var.master_password
  parameter_group_name  = aws_db_parameter_group.rds-mysql.name
  allocated_storage    = 20
  storage_type         = "gp2"
  max_allocated_storage = 150
  backup_retention_period = 5
  deletion_protection  = true
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  skip_final_snapshot = true
  multi_az = false
  //name = "${var.client_name}_${var.environment}_db"
  #enabled_cloudwatch_logs_exports = ["mysql"]
  #monitoring_interval = 60
  #performance_insights_enabled = true
  //kms_key_id = var.kms_arn
  //storage_encrypted = true

}

resource "aws_db_parameter_group" "rds-mysql" {
  name   = "${var.client_name}-${var.environment}-rds-mysql"
  family = "mysql5.7"
  description = "RDS MySql parameter group"

  /*parameter {
    name = "max_prepared_transactions"
    value = var.max_prepared_transactions
    apply_method = "pending-reboot"
  }*/


  parameter {
    name = "max_connections"
    value = var.max_connections
    apply_method = "pending-reboot"
  }

  /*parameter {
    name = "work_mem"
    value = var.work_mem
    apply_method = "pending-reboot"
  }*/
}


resource "aws_db_subnet_group" "db-subnet-group" {
  name = "${var.client_name}-${var.environment}-db-subnet-group"
  subnet_ids = [for subnet_ids in var.aws_private_subnet: subnet_ids]

  tags = {
    Name = "${var.client_name}-${var.environment}-db-subnet-group"
    Environment = var.environment
  }
}
