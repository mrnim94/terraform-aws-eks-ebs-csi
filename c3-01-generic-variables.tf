# Input Variables - Placeholder file
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "SAP"
}

variable "bucket_remote_state" {
  description = "bucket name of eks cluster that saves the remote state"
  type = string
  default = "terraform-on-aws-eks-nim"
}

variable "key_remote_state" {
  description = "The path to the state file inside the bucket"
  type = string
  default = "dev/eks-cluster/terraform.tfstate"
}




