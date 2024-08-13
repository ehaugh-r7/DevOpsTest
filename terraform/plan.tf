provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_docdb_cluster_instance" "test_docdb_instance" {
  count              = 3
  cluster_identifier = aws_docdb_cluster.test_docdb_cluster.id
  instance_class     = "db.r5.large"
}

resource "aws_docdb_cluster" "test_docdb_cluster" {
  cluster_identifier = "docdb-cluster-demo"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

resource "aws_neptune_cluster" "test_neptune_cluster" {
  cluster_identifier                  = "neptune-cluster-demo"
  engine                              = "neptune"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = true
  apply_immediately                   = true
}

resource "aws_neptune_cluster_instance" "test_neptune_instance" {
  count              = 2
  cluster_identifier = aws_neptune_cluster.test_neptune_cluster.id
  engine             = "neptune"
  instance_class     = "db.r4.large"
  apply_immediately  = true
}
