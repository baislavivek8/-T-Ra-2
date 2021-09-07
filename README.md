#Terraform Template for Dynamic ENV 

Variables Required for the Terraform template to work: 

aws_region = "us-east-1"
aws_peer_region = "ap-south-1"    
aws_peer_profile = "demo"         # AWS Profile of Demo Account
aws_profile = "test"              # AWS Profile of Client Account
client_name = "snduk"
domain_name = "snduk.com"
az_count = "2"
environment = "prod"
vpc_cidr = "10.12.0.0/16"
vpn_port_22_security_group_id = "sg-0b4e09288bece46d2"
db_port = 3306
max_prepared_transactions = 150
max_connections = 150
work_mem = 5120
audit_trail_enabled = false
master_password = "M54DUpjp9yc9Vd83"
master_user = "root"
db_instance_class = "db.t2.micro"
peer_vpc_id = "vpc-0f2123bb78313ae45"
peer_cidr = "10.160.0.0/16"
ami_id = "ami-00e87074e52e6c9f9"
######
