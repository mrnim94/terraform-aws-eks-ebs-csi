# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = var.bucket_remote_state
    key    = var.key_remote_state
    region = var.aws_region
  }
}